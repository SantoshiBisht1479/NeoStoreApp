import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/editProfileBloc/editProfileBloc.dart';
import 'package:neostore/bloc/editProfileBloc/editProfile_events.dart';
import 'package:neostore/bloc/editProfileBloc/editProfile_states.dart';
import 'package:neostore/model/update_req_detail_model.dart';
import 'package:neostore/pallet.dart';
import 'package:sizer/sizer.dart';

class EditProfilePage extends StatefulWidget {
  var accessToken;
  EditProfilePage({@required this.accessToken}) : assert(accessToken != null);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var currentAccessToken;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController profileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    currentAccessToken = widget.accessToken;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.black38, BlendMode.darken),
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover)),
        ),
        BlocListener<EditProfileBloc, EditProfileStates>(
          listener: (context, state) {
            if (state is EditProfileSuccessState) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                state.updateResponseUserDetailModel.message,
                style: successtextStyle,
              )));
              firstNameController.clear();
              lastNameController.clear();
              emailController.clear();
              phoneController.clear();
              dobController.clear();
            }
            if (state is EditProfileFailureState) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text(state.failureErrorModel.message)));
            }
          },
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Edit Profile'),
              actions: [
                InkWell(
                  onTap: () {
                    print('searching...');
                  },
                  child: Image.asset('assets/images/search_icon.png'),
                )
              ],
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      profileImage(),
                      firstName(),
                      lastName(),
                      email(),
                      phoneNumber(),
                      dateOfBirth(),
                      submitbutton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget profileImage() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: CircleAvatar(
        maxRadius: 70,
        backgroundImage: AssetImage('assets/images/user_male.png'),
      ),
    );
  }

  Widget firstName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: TextFormField(
        controller: firstNameController,
        validator: (value) {
          if (value.isEmpty) {
            return 'First Name is required';
          } else {
            return null;
          }
        },
        style: textFieldStyle,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            //disabledBorder: textFieldBorder,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedBorder,
            errorStyle: errorTextStyle,
            enabledBorder: textFieldBorder,
            hintText: 'First Name',
            hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/username_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget lastName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: TextFormField(
        controller: lastNameController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Last Name is required';
          } else {
            return null;
          }
        },
        style: textFieldStyle,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            //disabledBorder: textFieldBorder,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedBorder,
            errorStyle: errorTextStyle,
            enabledBorder: textFieldBorder,
            hintText: 'Last Name',
            hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/username_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget email() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: TextFormField(
        controller: emailController,
        validator: (value) {
          if (value.isEmpty | !value.contains('@')) {
            return 'Enter Valid Email';
          } else {
            return null;
          }
        },
        style: textFieldStyle,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            //disabledBorder: textFieldBorder,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedBorder,
            errorStyle: errorTextStyle,
            enabledBorder: textFieldBorder,
            hintText: 'Email',
            hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/email_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget phoneNumber() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: TextFormField(
        controller: phoneController,
        cursorColor: Colors.white,
        keyboardType: TextInputType.phone,
        validator: (value) => value.isEmpty ? 'Enter phone number' : null,
        style: textFieldStyle,
        decoration: InputDecoration(
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedBorder,
            errorStyle: errorTextStyle,
            enabledBorder: textFieldBorder,
            hintText: 'Phone Number',
            hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/cellphone.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget dateOfBirth() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: TextFormField(
        controller: dobController,
        cursorColor: Colors.white,
        keyboardType: TextInputType.datetime,
        validator: (value) => value.isEmpty ? 'DOB is required' : null,
        style: textFieldStyle,
        decoration: InputDecoration(
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedBorder,
            errorStyle: errorTextStyle,
            enabledBorder: textFieldBorder,
            hintText: 'DOB',
            hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/dob_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget submitbutton() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          UpdateReqUserDetailModel updateReqUserDetailModel =
              UpdateReqUserDetailModel(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  phoneNo: phoneController.text,
                  dob: dobController.text,
                  profilePic:
                      "https://cutewallpaper.org/21/anime-boy-profile-picture/Anime-Boys-Drawception-Profile.jpg");

          BlocProvider.of<EditProfileBloc>(context).add(EditUserProfile(
              accessToken: currentAccessToken,
              updateReqUserDetailModel: updateReqUserDetailModel));
          // try {
          //   var response = await NetworkServices().updateDetailRequest(
          //       currentAccessToken, updateReqUserDetailModel);

          //   if (response.statusCode == 200) {
          //     var responsedata = UpdateResponseUserDetailModel.fromJson(
          //         json.decode(response.data));
          //     print(responsedata.userMsg);
          //     _scaffoldKey.currentState.showSnackBar(SnackBar(
          //         content: Text(
          //       responsedata.message,
          //       style: successtextStyle,
          //     )));
          //     firstNameController.clear();
          //     lastNameController.clear();
          //     emailController.clear();
          //     phoneController.clear();
          //     dobController.clear();
          //   }
          // } on DioError catch (e) {
          //   var errorData =
          //       LoginErrorModel.fromJson(json.decode(e.response.data));
          //   _scaffoldKey.currentState
          //       .showSnackBar(SnackBar(content: Text(errorData.message)));
          // }
        }
        return null;
      },
      child: Padding(
        padding: EdgeInsets.only(top: 2.0.h),
        child: Container(
          alignment: Alignment.center,
          //padding: EdgeInsets.only(top: 2.0.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          width: double.infinity,
          height: 60,
          child: Text(
            'SUBMIT',
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
