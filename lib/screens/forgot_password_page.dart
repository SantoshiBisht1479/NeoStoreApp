import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/forgotPasswordBloc/forgotPassword_bloc.dart';
import 'package:neostore/bloc/forgotPasswordBloc/forgotPassword_events.dart';
import 'package:neostore/bloc/forgotPasswordBloc/forgotPassword_states.dart';
import 'package:neostore/model/forgot_pass_request_model.dart';
import 'package:neostore/pallet.dart';
import 'package:neostore/screens/registration.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
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
        BlocListener<ForgotPasswordBloc, ForgotPasswordStates>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccessState) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).accentColor,
                  content: Text(
                    '${state.forgotPassResponsetModel.userMsg} !',
                    style: TextStyle(color: Colors.green, fontSize: 14.0.sp),
                  )));
              emailController.clear();
            }
            if (state is ForgotPasswordFailureState) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).accentColor,
                  content: Text(
                    '${state.forgotPassResponsetModel.userMsg} !',
                    style: TextStyle(color: Colors.green, fontSize: 14.0.sp),
                  )));
            }
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Text('Forgot Password'),
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
                        padding: EdgeInsets.only(top: 28.0.h, bottom: 8.0.h),
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
                            emailTextField(),
                            submitButton(),
                            newAccountWidget()
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

  Widget emailTextField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: TextFormField(
        controller: emailController,
        validator: (value) {
          if (value.isEmpty | !value.contains('@')) {
            return ' ! Enter Valid Email';
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
            hintText: 'Email',
            hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/email_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget submitButton() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          ForgotPassRequestModel forgotPassRequestModel =
              ForgotPassRequestModel(email: emailController.text);

          BlocProvider.of<ForgotPasswordBloc>(context).add(
              ForgotUserPasswordEvent(
                  forgotPassRequestModel: forgotPassRequestModel));

          // try {
          //   var response = await NetworkServices()
          //       .forgotPassrequest(forgotPassRequestModel);
          //   if (response.statusCode == 200) {
          //     print(response.data);
          //     var responseData =
          //         ForgotPassResponsetModel.fromJson(json.decode(response.data));

          //     _scaffoldKey.currentState.showSnackBar(SnackBar(
          //         backgroundColor: Theme.of(context).accentColor,
          //         content: Text(
          //           '${responseData.userMsg} !',
          //           style: TextStyle(color: Colors.green, fontSize: 14.0.sp),
          //         )));
          //     emailController.clear();
          //   }
          // } on DioError catch (e) {
          //   var responseData =
          //       ForgotPassResponsetModel.fromJson(json.decode(e.response.data));

          //   _scaffoldKey.currentState.showSnackBar(SnackBar(
          //       backgroundColor: Theme.of(context).accentColor,
          //       content: Text(
          //         '${responseData.userMsg} !',
          //         style: TextStyle(color: Colors.green, fontSize: 14.0.sp),
          //       )));
          // }

          // // NetworkServices().getLoginResponse(loginRequestModel);

          // try {
          //   var response =
          //       await NetworkServices().loginRequest(loginRequestModel);
          //   if (response.statusCode == 200) {
          //     print(response.data);
          //     var dataresponse =
          //         RegisterResponseModel.fromJson(json.decode(response.data));
          //     print(dataresponse.data.firstName);
          //     Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(builder: (context) => HomePage()),
          //         (route) => false);
          //   }
          // } on DioError catch (e) {
          //   print(e.response);
          //   var errordata =
          //       LoginErrorModel.fromJson(json.decode(e.response.data));
          //   _scaffoldKey.currentState
          //       .showSnackBar(SnackBar(content: Text(errordata.userMsg)));
          // }
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
            'SUBMIT',
            style: TextStyle(
                color: Color(0xffe91c1a),
                fontSize: 22.0.sp,
                fontFamily: 'GothamMedium'),
          ),
        ),
      ),
    );
  }

  Widget newAccountWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 25.0.h),
      child: Container(
        child: RichText(
          text: TextSpan(
              text: 'DONT HAVE AN ACCOUNT ?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0.sp,
                  fontFamily: 'GothamMedium'),
              children: [
                WidgetSpan(
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 6.0.h,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationPage()));
                    },
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
