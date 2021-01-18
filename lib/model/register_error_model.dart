class RegisterErrorModel {
  int status;
  Data data;
  String message;
  String userMsg;

  RegisterErrorModel({this.status, this.data, this.message, this.userMsg});

  RegisterErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    userMsg = json['user_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['user_msg'] = this.userMsg;
    return data;
  }
}

class Data {
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  String gender;
  String phoneNo;

  Data(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.confirmPassword,
      this.gender,
      this.phoneNo});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    gender = json['gender'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    data['gender'] = this.gender;
    data['phone_no'] = this.phoneNo;
    return data;
  }
}
