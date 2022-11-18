import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintenance_home_application/screens/ChatRooms/chat_room.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/myprofile.dart';
import '../Language/lanugage_Screen.dargt.dart';
import 'accountSetting.dart';
import 'package:get/get.dart';
import 'logout.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var currentPage = DrawerSections.myProfile;


  final List locale = [
    {'name':'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'اردو', 'locale': Locale('ur', 'PK')}
  ];

  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  buildDialogBox(BuildContext context){
    showDialog(
        context: context,
        builder: (builder){
          return AlertDialog(
            title: Text("changelanguage".tr),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.myProfile) {
      container = MyProfileScreen();
    } else if (currentPage == DrawerSections.accountSetting) {
      container = AccountSetting();
    }else if(currentPage == DrawerSections.changeLanguage){
      container = LanguageScreen();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "mydashboard".tr,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.teal,
                      Color(0xff5f9ea0),
                    ]
                )
            ),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                accountName:
                Text(
                  "Shakeeb Khan",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                ),
                accountEmail: Text(
                  "shakeeb@gmail.com",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                  currentAccountPicture: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
            ),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.teal,
                  Color(0xff5f9ea0),
                ]
            )
        ),
        child: Column(
          // shows the list of menu drawer
          children: [
            menuItem(1, "myprofile".tr, Icons.person,
                currentPage == DrawerSections.myProfile ? true : false),
            Divider(thickness: 2),
            menuItem(2, "account".tr, Icons.settings,
                currentPage == DrawerSections.accountSetting ? true : false),
            Divider(thickness: 2),
            menuItem(3, "changelanguage".tr, Icons.color_lens, currentPage == DrawerSections.changeLanguage ? true : false),
          ],
        ),
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.black : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.myProfile;
            } else if (id == 2) {
              currentPage = DrawerSections.accountSetting;
            } else if(id == 3){
              currentPage = DrawerSections.changeLanguage;
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Choice")));
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  myProfile,
  accountSetting,
  changeLanguage,
}
