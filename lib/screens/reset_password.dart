import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/resetPasswordBloc/resetPassword_bloc.dart';
import 'package:neostore/bloc/resetPasswordBloc/resetPassword_events.dart';
import 'package:neostore/bloc/resetPasswordBloc/resetPassword_states.dart';
import 'package:neostore/model/change_PassReq_model.dart';
import 'package:neostore/pallet.dart';
import 'package:sizer/sizer.dart';

class ResetPasswordPage extends StatefulWidget {
  var accessToken;
  ResetPasswordPage({@required this.accessToken}) : assert(accessToken != null);
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var currentAccessToken;
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController conFirmPasswordController = TextEditingController();
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
        BlocListener<ResetPasswordBloc, ResetPasswordStates>(
          listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                state.changePasswordResModel.message,
                style: successtextStyle,
              )));
              currentPassController.clear();
              newPasswordController.clear();
              conFirmPasswordController.clear();
            }
            if (state is ResetpasswordFailureState) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text(state.loginErrorModel.message)));
            }
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text('Reset Password'),
            ),
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.5.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0.h, bottom: 6.0.h),
                        child: Text(
                          'NeoSTORE',
                          style: neoStoreTextStyle,
                        ),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            currentPassField(),
                            newPassword(),
                            confirmPassword(),
                            resetPassButton(),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget currentPassField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: TextFormField(
        controller: currentPassController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter current Password';
          } else {
            return null;
          }
        },
        style: textFieldStyle,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedBorder,
            errorStyle: errorTextStyle,
            enabledBorder: textFieldBorder,
            hintText: 'Current Password',
            hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/password_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget newPassword() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: TextFormField(
        controller: newPasswordController,
        validator: (value) {
          if (value.length < 8) {
            return 'Password should be max 8 characters long';
          } else {
            return null;
          }
        },
        style: textFieldStyle,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedBorder,
            errorStyle: errorTextStyle,
            enabledBorder: textFieldBorder,
            hintText: 'New Password',
            hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/cpassword_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget confirmPassword() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: TextFormField(
        controller: conFirmPasswordController,
        validator: (value) {
          if (value.length < 8) {
            return 'Password should be max 8 characters long';
          } else {
            return null;
          }
        },
        style: textFieldStyle,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedBorder,
            errorStyle: errorTextStyle,
            enabledBorder: textFieldBorder,
            hintText: 'Confirm Password',
            hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/password_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget resetPassButton() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          if (newPasswordController.text != conFirmPasswordController.text) {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(
              'Password doesnot match. Try Again !',
              style: errorTextStyle,
            )));
          } else {
            print('accessToken: $currentAccessToken');
            ChangePasswordReqModel changePasswordReqModel =
                ChangePasswordReqModel(
                    oldPassword: currentPassController.text,
                    password: newPasswordController.text,
                    confirmPassword: conFirmPasswordController.text);

            BlocProvider.of<ResetPasswordBloc>(context).add(ResetPassword(
                accessToken: currentAccessToken,
                changePasswordReqModel: changePasswordReqModel));

            // try {
            //   var response = await NetworkServices().changePassRequest(
            //       currentAccessToken, changePasswordReqModel);

            //   if (response.statusCode == 200) {
            //     var responsedata =
            //         LoginErrorModel.fromJson(json.decode(response.data));
            //     _scaffoldKey.currentState.showSnackBar(SnackBar(
            //         content: Text(
            //       responsedata.message,
            //       style: successtextStyle,
            //     )));
            //     currentPassController.clear();
            //     newPasswordController.clear();
            //     conFirmPasswordController.clear();
            //   }
            // } on DioError catch (e) {
            //   var errorData =
            //       LoginErrorModel.fromJson(json.decode(e.response.data));
            //   _scaffoldKey.currentState
            //       .showSnackBar(SnackBar(content: Text(errorData.message)));
            // }
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 4.0.h),
        child: Container(
          alignment: Alignment.center,
          //padding: EdgeInsets.only(top: 2.0.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          width: double.infinity,
          height: 60,
          child: Text(
            'RESET PASSWORD',
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
