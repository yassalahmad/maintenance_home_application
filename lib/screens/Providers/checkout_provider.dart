import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;

  TextEditingController mobileNoController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  var setLocation;

  void validator(context) async {
    if (mobileNoController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Mobile Number is Empty");
    } else if (mobileNoController.text.isEmpty) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (cityController.text.isEmpty) {
      Fluttertoast.showToast(msg: "city is empty");
    }
    // ignore: unnecessary_null_comparison
    else if (setLocation?.longitude == null) {
      Fluttertoast.showToast(msg: "setLoaction is empty");
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("Service Providers Address")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "Mobile Number": mobileNoController.text,
        "Area Name": areaController.text,
        "City Name": cityController.text,
        "longitude": setLocation?.longitude,
        "latitude": setLocation?.latitude,
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }
}