class LoginResponseModel {
  int status;
  List<Data> data;
  String message;
  String userMsg;

  LoginResponseModel({this.status, this.data, this.message, this.userMsg});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    userMsg = json['user_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['user_msg'] = this.userMsg;
    return data;
  }
}

class Data {
  int id;
  int roleId;
  String firstName;
  String lastName;
  String email;
  String username;
  //Null profilePic;
  //Null countryId;
  String gender;
  int phoneNo;
  //Null dob;
  bool isActive;
  String created;
  String modified;
  String accessToken;

  Data(
      {this.id,
      this.roleId,
      this.firstName,
      this.lastName,
      this.email,
      this.username,
      //this.profilePic,
      //this.countryId,
      this.gender,
      this.phoneNo,
      //this.dob,
      this.isActive,
      this.created,
      this.modified,
      this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    //profilePic = json['profile_pic'];
    //countryId = json['country_id'];
    gender = json['gender'];
    phoneNo = json['phone_no'];
    //dob = json['dob'];
    isActive = json['is_active'];
    created = json['created'];
    modified = json['modified'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['username'] = this.username;
    // data['profile_pic'] = this.profilePic;
    //data['country_id'] = this.countryId;
    data['gender'] = this.gender;
    data['phone_no'] = this.phoneNo;
    //data['dob'] = this.dob;
    data['is_active'] = this.isActive;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['access_token'] = this.accessToken;
    return data;
  }
}
