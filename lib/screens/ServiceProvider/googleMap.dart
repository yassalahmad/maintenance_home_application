import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maintenance_home_application/screens/Providers/UserAuthentication_Provider.dart';
import 'package:maintenance_home_application/screens/Providers/checkout_provider.dart';
import 'package:provider/provider.dart';


class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  
  static final CameraPosition _kGooglePlex = CameraPosition(target: LatLng(20.5937, 78.9629));
  GoogleMapController? _controller;
  Location _location = Location();
  void onMapCreated(GoogleMapController value){
    _controller = value;
    _location.onLocationChanged.listen((event) {
      _controller?.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(
                      event.latitude ?? 0.0, event.longitude ?? 0.0,
                  ),
                zoom: 15,
              ),
          ));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    UserAuthenticationProvider userAuthenticationProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: _kGooglePlex,
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: onMapCreated,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(right: 60, left: 10, bottom: 40, top: 40),
                  child: MaterialButton(
                    onPressed: () async{
                      await _location.getLocation().then((value)  {
                        setState(() {
                           userAuthenticationProvider.setLocation = value;
                        });
                      });
                    },
                    color: Colors.teal,
                    child: Text("Set My Location", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    shape: StadiumBorder(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
