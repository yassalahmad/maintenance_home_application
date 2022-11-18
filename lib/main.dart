import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maintenance_home_application/screens/Helper/authenticate.dart';
import 'package:maintenance_home_application/screens/Helper/helperfunction.dart';
import 'package:maintenance_home_application/screens/Language/local_string.dart';
import 'package:maintenance_home_application/screens/Providers/UserAuthentication_Provider.dart';
import 'package:maintenance_home_application/screens/Providers/get_services_providers.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/signin.dart';
import 'package:maintenance_home_application/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  bool? userIsLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async{
    await HelperFunction.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuthenticationProvider>(create: (context) => UserAuthenticationProvider()),
        ChangeNotifierProvider<ServiceProvider>(create: (context)=> ServiceProvider()),
      ],
      child: GetMaterialApp(
        translations: LocalString(),
        locale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        title: 'Home Maintenance App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        // home: userIsLoggedIn !=null ? WelcomeScreen() : Authenticate(),
        home: WelcomeScreen(),
      ),
    );
  }
}

