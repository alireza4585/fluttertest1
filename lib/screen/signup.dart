import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/bloc/auth/bloc/auth_bloc.dart';
import 'package:fluttertest1/util/snakbar.dart';

// ignore: camel_case_types
class Sign_Screen extends StatefulWidget {
  const Sign_Screen({super.key});

  @override
  State<Sign_Screen> createState() => _Sign_ScreenState();
}

FocusNode _focusNode1 = FocusNode();
FocusNode _focusNode2 = FocusNode();
FocusNode _focusNode3 = FocusNode();
final email = TextEditingController();
final password = TextEditingController();
final passwordConfirme = TextEditingController();
bool visibil = true;

// ignore: camel_case_types
class _Sign_ScreenState extends State<Sign_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(width: 96.w, height: 100.h),
                Center(
                  child: Image.asset(
                    'images/logo.jpg',
                  ),
                ),
                SizedBox(height: 120.h),
                textfild(email, _focusNode1, 'Email', Icons.email),
                SizedBox(height: 19.h),
                textfild(password, _focusNode2, 'password', Icons.lock),
                SizedBox(height: 19.h),
                textfild(passwordConfirme, _focusNode3, 'passwordConfirme',
                    Icons.lock),
                SizedBox(height: 40.h),
                if (state is AuthInitial) ...{
                  signIN(email.text, password.text, passwordConfirme.text),
                } else if (state is AuthLoding) ...{
                  const CircularProgressIndicator(color: Colors.blue)
                } else if (state is AuthSignup) ...[
                  state.signUP.fold((left) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      dialogBuilder(context, left);
                    });
                    return signIN(
                        email.text, password.text, passwordConfirme.text);
                  }, (right) {
                    return const Text('');
                  })
                ],
                SizedBox(height: 15.h),
                have(),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding forget() {
    return Padding(
      padding: EdgeInsets.only(left: 220.w),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Padding have() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Do you have an account?  ",
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget signIN(String email, String password, String passwordConfirme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthBloc>(context)
              .add(Auth_event(email, false, password, passwordConfirme));
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            'Sign up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget textfild(TextEditingController controller, FocusNode focusNode,
      String typeName, IconData iconss) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: typeName,
            prefixIcon: Icon(
              iconss,
              color: focusNode.hasFocus ? Colors.black : Colors.grey[600],
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: const Color(0xffc5c5c5),
                width: 2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
