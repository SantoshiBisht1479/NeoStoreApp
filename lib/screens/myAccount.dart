import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/myAccountBloc/myAccountBloc.dart';
import 'package:neostore/bloc/myAccountBloc/myAccountEvents.dart';
import 'package:neostore/bloc/myAccountBloc/myAccountStates.dart';
import 'package:neostore/model/get_user_detail_model.dart';
import 'package:neostore/pallet.dart';
import 'package:neostore/screens/editProfile.dart';
import 'package:neostore/screens/reset_password.dart';
import 'package:sizer/sizer.dart';

class MyAccountPage extends StatefulWidget {
  String accessToken;
  MyAccountPage({@required this.accessToken});
  // GetUserDetailModel userDetailModel;
  // MyAccountPage({@required this.userDetailModel})
  // : assert(userDetailModel != null);
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  GetUserDetailModel getUserDetailModel;
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   getUserDetailModel = widget.userDetailModel;
    // });
    setState(() {
      print('accessToken: ${widget.accessToken}');
      BlocProvider.of<MyAccountBloc>(context)
          .add(GetUserDetailEvent(accessToken: widget.accessToken));
    });

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
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('My Account'),
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
          body: BlocBuilder<MyAccountBloc, MyAccountState>(
              builder: (context, state) {
            if (state is InitialMyAccountState) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            if (state is LoadingStateAccountState) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
            if (state is LoadedAccountState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                      child: Column(
                        children: [
                          profileImage(state),
                          firstName(state),
                          lastName(state),
                          email(state),
                          phoneNumber(state),
                          dateOfBirth(state),
                          editProfile(),
                        ],
                      ),
                    ),
                    resetPassword()
                  ],
                ),
              );
            }
            if (state is FailureAccountState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
          }),
        )
      ],
    );
  }

  Widget profileImage(LoadedAccountState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: CircleAvatar(
        maxRadius: 70,
        backgroundImage:
            // getUserDetailModel.data.userData.profilePic != null
            //     ? NetworkImage('${getUserDetailModel.data.userData.profilePic}')
            AssetImage('assets/images/user_male.png'),
      ),
    );
  }

  Widget firstName(LoadedAccountState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: TextFormField(
        initialValue: '${state.getUserDetailModel.data.userData.firstName}',
        //controller: firstNameController,
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return 'Enter Valid Email';
        //   } else {
        //     return null;
        //   }
        // },
        style: accountTextStyle,

        enabled: false,
        //autofocus: true,
        //cursorColor: Colors.white,
        decoration: InputDecoration(
            disabledBorder: textFieldBorder,
            //focusedBorder: focusedBorder,
            //errorBorder: errorBorder,
            //focusedErrorBorder: focusedBorder,
            //errorStyle: errorTextStyle,
            //enabledBorder: textFieldBorder,
            //hintText: 'First Name',
            //hintStyle: textFieldhintStyle,
            prefixIcon: Image(
              image: AssetImage('assets/images/username_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget lastName(LoadedAccountState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: TextFormField(
        initialValue: '${state.getUserDetailModel.data.userData.lastName}',
        style: accountTextStyle,
        enabled: false,
        decoration: InputDecoration(
            disabledBorder: textFieldBorder,
            prefixIcon: Image(
              image: AssetImage('assets/images/username_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget email(LoadedAccountState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: TextFormField(
        initialValue: '${state.getUserDetailModel.data.userData.email}',
        style: accountTextStyle,
        enabled: false,
        decoration: InputDecoration(
            disabledBorder: textFieldBorder,
            prefixIcon: Image(
              image: AssetImage('assets/images/email_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget phoneNumber(LoadedAccountState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: TextFormField(
        initialValue: '${state.getUserDetailModel.data.userData.phoneNo}',
        style: accountTextStyle,
        enabled: false,
        decoration: InputDecoration(
            disabledBorder: textFieldBorder,
            prefixIcon: Image(
              image: AssetImage('assets/images/cellphone.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget dateOfBirth(LoadedAccountState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: TextFormField(
        initialValue: state.getUserDetailModel.data.userData.dob == null
            ? 'Not Mentioned'
            : '${state.getUserDetailModel.data.userData.dob}',
        style: accountTextStyle,
        enabled: false,
        decoration: InputDecoration(
            disabledBorder: textFieldBorder,
            prefixIcon: Image(
              image: AssetImage('assets/images/dob_icon.png'),
            ),
            border: OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }

  Widget editProfile() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditProfilePage(accessToken: widget.accessToken)))
            .then((value) {
          setState(() {});
        });
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
            'EDIT PROFILE',
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }

  Widget resetPassword() {
    return GestureDetector(
      onTap: () {
        //print(getUserDetailModel.data.userData.accessToken);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPasswordPage(
                    accessToken: '${widget.accessToken}'))).then((value) {
          setState(() {});
        });
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8.0.h),
        child: Container(
          alignment: Alignment.center,
          //padding: EdgeInsets.only(top: 2.0.h),
          decoration: BoxDecoration(color: Colors.white),
          width: double.infinity,
          height: 60,
          child: Text(
            'RESET PASSWORD',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0.sp,
                fontFamily: 'GothamMedium'),
          ),
        ),
      ),
    );
  }
}
