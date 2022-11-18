import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maintenance_home_application/welcome_screen.dart';

import '../ServiceProvider/pdrawer.dart';

class WelLanguageScreen extends StatefulWidget {
  const WelLanguageScreen({Key? key}) : super(key: key);

  @override
  _WelLanguageScreenState createState() => _WelLanguageScreenState();
}

class _WelLanguageScreenState extends State<WelLanguageScreen> {



  final List locale = [
    {'name':'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'اردو', 'locale': Locale('ur', 'PK')}
  ];

  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }




  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Change Language"),
      content: Container(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: locale.length,
          itemBuilder: (context, index){
            return GestureDetector(
                onTap: (){
                  print(locale[index]['name']);
                  updateLanguage(locale[index]['locale']);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
                },
                child: Text(locale[index]['name']));
          },
          separatorBuilder: (context, index){
            return Divider(
              color: Colors.indigo,
            );
          },

        ),
      ),
    );
  }
}
