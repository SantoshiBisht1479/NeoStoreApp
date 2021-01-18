import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/loginBloc/loginBloc.dart';
import 'package:neostore/bloc/loginBloc/login_events.dart';
import 'package:neostore/bloc/loginBloc/login_states.dart';
import 'package:neostore/model/login_request_model.dart';
import 'package:neostore/pallet.dart';
import 'package:neostore/screens/forgot_password_page.dart';
import 'package:neostore/screens/home_page.dart';
import 'package:neostore/screens/registration.dart';
import 'package:neostore/shared_preference/shared_preference.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
        BlocListener<LoginBloc, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              SharedPrefernceData.storeToken(state.accessToken);
              SharedPrefernceData.storeUser(state.userName);
              SharedPrefernceData.storeLoggedStatus();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false).then((value) {
                setState(() {});
              });
            }
            if (state is LoginfailureState) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                state.loginErrorModel.userMsg,
                style: snackBarErrortextStyle,
              )));
            }
            // if (state is LoginRegisterState) {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => RegistrationPage()));
            // }
          },
          child: Scaffold(
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
                            emailTextField(),
                            passwordTextField(),
                            loginButton(),
                            forgotPassword(),
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
            return 'Enter Valid Email';
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

  Widget passwordTextField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: TextFormField(
        controller: passwordController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter Valid Password';
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
            hintText: 'Password',
            hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/password_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget loginButton() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          //print('Logged In');
          LoginRequestModel loginRequestModel = LoginRequestModel(
              email: emailController.text, password: passwordController.text);

          BlocProvider.of<LoginBloc>(context)
              .add(LoginUserEvent(loginRequestModel: loginRequestModel));
          //SharedPrefernceData.storeLoggedStatus();
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
            'LOGIN',
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ForgotPasswordPage())),
      child: Padding(
        padding: EdgeInsets.all(2.0.h),
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(3.0.h),
          child: Text(
            'Forgot Password ?',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0.sp,
                fontFamily: 'GothamMedium'),
          ),
        ),
      ),
    );
  }

  Widget newAccountWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 14.0.h),
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
