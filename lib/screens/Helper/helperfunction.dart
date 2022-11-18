import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {

  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  // Saving Data To SharedPreference
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameLoggedInSharedPreference(String isUserNameLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, isUserNameLoggedIn);
  }

  static Future<bool> saveUserEmailLoggedInSharedPreference(String isUserEmailLoggedIn)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, isUserEmailLoggedIn);
  }

  // Get Data From SharedPreference
  static Future<bool?> getUserLoggedInSharedPreference()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String?> getUserNameLoggedInSharedPreference()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<String?> getUserEmailLoggedInSharedPreference()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserEmailKey);
  }

}

