import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefernceData {
  static String loggedIn_User_Detail = 'UserDetail';
  static String tokenKey = 'keyToken';

  //static bool isUserLoggedIn;

  static SharedPreferences _preferences;

  static Future<SharedPreferences> get preferences async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences;
  }

  static storeLoggedStatus() async {
    var preference = await preferences;
    //isUserLoggedIn = true;
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

  // static storeLoggedUserDetail(
  //     RegisterResponseModel registerResponseModel) async {
  //   var preference = await preferences;

  //   preference.setString(
  //       loggedIn_User_Detail, json.encode(registerResponseModel.data.toMap()));
  // }

  // static Future<Data> getLoggedUserDetail() async {
  //   var preference = await preferences;
  //   // RegisterResponseModel registerModel = RegisterResponseModel.fromJson(
  //   //     json.decode(preference.getString(loggedIn_User_Detail)));

  //   Data dataModel =
  //       Data.fromMap(json.decode(preference.getString(loggedIn_User_Detail)));
  //   //var registerModel = preference.getString(loggedIn_User_Detail);
  //   //print(dataModel);
  //   return dataModel;
  // }
}
