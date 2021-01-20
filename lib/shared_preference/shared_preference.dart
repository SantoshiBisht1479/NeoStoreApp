import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefernceData {
  static String loggedIn_User_Detail = 'UserDetail';
  static String tokenKey = 'keyToken';

  static SharedPreferences _preferences;

  static Future<SharedPreferences> get preferences async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences;
  }

  static storeLoggedStatus() async {
    var preference = await preferences;
    preference.setBool(loggedIn_User_Detail, true);
  }

  static getLoggedUserStatus() async {
    var preference = await preferences;
    bool isUserLoggedIn = preference.getBool(loggedIn_User_Detail);
    return isUserLoggedIn;
  }

  static storeToken(String accessToken) async {
    var pref = await preferences;
    pref.setString(tokenKey, accessToken);
  }

  static getToken() async {
    var pref = await preferences;
    String token = pref.getString(tokenKey);
    return token;
  }

  static storeUser(String userName) async {
    var pref = await preferences;
    pref.setString('user', userName);
  }

  static getuser() async {
    var pref = await preferences;
    String loggedUser = pref.getString('user');
    return loggedUser;
  }

  static removeData() async {
    var pref = await preferences;
    pref.remove('user');
    pref.remove(tokenKey);
    pref.remove(loggedIn_User_Detail);
  }
}
