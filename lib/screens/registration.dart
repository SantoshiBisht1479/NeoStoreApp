import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/registerBloc/registerBloc.dart';
import 'package:neostore/bloc/registerBloc/register_events.dart';
import 'package:neostore/bloc/registerBloc/register_states.dart';
import 'package:neostore/model/signup_request_model.dart';
import 'package:neostore/pallet.dart';
import 'package:neostore/screens/login_page.dart';
import 'package:sizer/sizer.dart';

enum Gender { male, female }

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  NetworkServices networkServices;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var gender = Gender.male;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    networkServices = NetworkServices();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterStates>(
      listener: (context, state) {
        if (state is SuccessRegisterState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));

          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          phoneController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        }
        if (state is FailureRegisterState) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(
            '${state.loginErrorModel.userMsg} already exist.',
            style: snackBarErrortextStyle,
          )));
        }
      },
      child: Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('Register'),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black38, BlendMode.darken))),
            child: Padding(
              padding: EdgeInsets.only(right: 1.0.h, left: 1.0.h, top: 18.0.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(1.0.h),
                        child: Text(
                          'NeoSTORE',
                          style: neoStoreTextStyle,
                        ),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            firstName(),
                            lastName(),
                            email(),
                            password(),
                            confirmPassword(),
                            genderRow(),
                            phoneNumber(),
                            termCondition(),
                            registerButton()
                            //genderofUser()
                          ],
                        )),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget firstName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: TextFormField(
        controller: firstNameController,
        validator: (value) {
          if (value.isEmpty) {
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
      //padding: EdgeInsets.symmetric(vertical: 3.0.h),
      child: TextFormField(
        style: textFieldStyle,
        cursorColor: Colors.white,
        controller: lastNameController,
        validator: (value) => value.isEmpty ? 'Enter last Name' : null,
        decoration: InputDecoration(
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
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: TextFormField(
        controller: emailController,
        style: textFieldStyle,
        cursorColor: Colors.white,
        validator: (value) => value.contains('@') ? null : 'Enter valid email',
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

  Widget password() {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 3.0.h),
      child: TextFormField(
        controller: passwordController,
        style: textFieldStyle,
        cursorColor: Colors.white,
        validator: (value) => value.length < 8
            ? 'Password should be more than 8 characters'
            : null,
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

  Widget confirmPassword() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: TextFormField(
        controller: confirmPasswordController,
        cursorColor: Colors.white,
        validator: (value) => value.length < 8
            ? 'Password should be more than 8 characters'
            : null,
        style: textFieldStyle,
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

  Widget genderRow() {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Row(
        children: [
          Text(
            'Gender',
            style: textFieldhintStyle,
          ),
          Flexible(
            flex: 4,
            child: RadioListTile(
                activeColor: Colors.white,
                title: Text(
                  'Male',
                  style: textRadioStyle,
                ),
                value: Gender.male,
                groupValue: gender,
                onChanged: (Gender value) {
                  setState(() {
                    gender = value;
                  });
                }),
          ),
          //Text('Male'),
          Flexible(
            flex: 5,
            child: RadioListTile(
                activeColor: Colors.white,
                title: Text(
                  'Female',
                  style: textRadioStyle,
                ),
                value: Gender.female,
                groupValue: gender,
                onChanged: (Gender value) {
                  setState(() {
                    gender = value;
                  });
                }),
          ),
          //Text('Female'),
        ],
      ),
    );
  }

  Widget phoneNumber() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
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

  Widget termCondition() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 2.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image(
                image: AssetImage('assets/images/checked_icon.png'),
              ),
            ),
            SizedBox(
              width: 2.0.h,
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 13.0.sp, fontFamily: 'GothamMedium'),
                    text: 'I agree the ',
                    children: [
                  TextSpan(
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 13.0.sp,
                          fontFamily: 'GothamMedium'),
                      text: 'Terms & Conditions')
                ]))
          ],
        ));
  }

  Widget registerButton() {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0.h),
        child: Container(
          //padding: EdgeInsets.only(top: 2.0.h),
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Text(
            'REGISTER',
            style: buttonTextStyle,
          ),
        ),
      ),
      onTap: () async {
        if (_formKey.currentState.validate()) {
          if (passwordController.text != confirmPasswordController.text) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text('Password doesnot match')));
          } else {
            RegisterRequestModel registerRequestModel = RegisterRequestModel(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: emailController.text,
                password: passwordController.text,
                confirmPassword: confirmPasswordController.text,
                gender:
                    '${gender.toString().substring(gender.toString().indexOf('.') + 1)}',
                phoneNo: num.parse(phoneController.text));

            BlocProvider.of<RegisterBloc>(context).add(
                RegisterUserEvent(registerRequestModel: registerRequestModel));

            // try {
            //   var result =
            //       await NetworkServices().register(registerRequestModel);
            //   if (result.statusCode == 200) {
            //     print(result.data);
            //     firstNameController.clear();
            //     lastNameController.clear();
            //     emailController.clear();
            //     phoneController.clear();
            //     passwordController.clear();
            //     confirmPasswordController.clear();
            //     // var dataresponse =
            //     //     RegisterResponseModel.fromJson(json.decode(result.data));

            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => LoginPage()));
            //   }
            // } on DioError catch (e) {
            //   print(e.response);
            //   var errordata =
            //       RegisterErrorModel.fromJson(json.decode(e.response.data));
            //   print(errordata.message);
            //   _scaffoldKey.currentState.showSnackBar(SnackBar(
            //       content: Text('${errordata.data.email} already exist.')));
            // }

            // print(result.toString());

          }
        }
      },
    );
  }
}
