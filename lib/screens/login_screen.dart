


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instacloneapp/resources/auth_methods.dart';
import 'package:instacloneapp/screens/home_screen.dart';
import 'package:instacloneapp/utils/colors.dart';
import 'package:instacloneapp/utils/utils.dart';

import '../widgest/text_field_inputs.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextEditingController = TextEditingController();

  final TextEditingController passwordTextEditingController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    //super.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
  }

  void loginUser() async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: emailTextEditingController.text, password: passwordTextEditingController.text);
    if(res == 'success'){
      Navigator.of(context as BuildContext).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    }else{
      showSnackBar(context as BuildContext, res);
    }
    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Flexible(child: Container(),flex: 2,),
              SvgPicture.asset('assets/ic_instagram.svg',color: primaryColor, height: 64,),
              const SizedBox(height: 64,),
              TextFieldInput(
                hintText: "enter your email",
                textInputType: TextInputType.emailAddress,
                textEditingController: emailTextEditingController,
              ),
              const SizedBox(height: 24,),
              TextFieldInput(
                hintText: "enter your password",
                textInputType: TextInputType.text,
                textEditingController: passwordTextEditingController,
                isPass: true,
              ),
              const SizedBox(height: 24,),
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isLoading ?  Center(child: CircularProgressIndicator(
                    color: primaryColor,
                  ),)
                      : const Text("Log in"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),

                      ),
                    ),
                    color: blueColor,
                  ),

                ),
              ),
              const SizedBox(height: 12,),
              Flexible(child: Container(),flex: 2,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Container(
                      child: Text("Don't have an account?",
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      child: Text("Sign up",style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              )





            ],
          ),
        ),
      ),
    );
  }
}