



import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instacloneapp/utils/colors.dart';

import '../widgest/text_field_inputs.dart';


class SignupScreen extends StatelessWidget {

  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  final TextEditingController bioTextEditingController = TextEditingController();
  final TextEditingController usernameTextEditingController = TextEditingController();

  @override
  void dispose() {
    //super.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    bioTextEditingController.dispose();
    usernameTextEditingController.dispose();

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


              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                      "https://www.iprcenter.gov/image-repository/blank-profile-picture.png/@@images/image.png"
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.add_a_photo),
                      ))
                ],
              ),
              const SizedBox(height: 24,),

              TextFieldInput(
                hintText: "enter your username",
                textInputType: TextInputType.text,
                textEditingController: usernameTextEditingController,
                isPass: true,
              ),
              const SizedBox(height: 24,),
              TextFieldInput(
                hintText: "enter your bio",
                textInputType: TextInputType.text,
                textEditingController: bioTextEditingController,
                isPass: true,
              ),
              const SizedBox(height: 24,),
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
                child: Container(
                  child: const Text("Log in"),
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
