



import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instacloneapp/resources/auth_methods.dart';
import 'package:instacloneapp/responsive/mobile_screen_layout.dart';
import 'package:instacloneapp/responsive/responsive_layout_screen.dart';
import 'package:instacloneapp/responsive/web_screen_layout.dart';
import 'package:instacloneapp/screens/login_screen.dart';
import 'package:instacloneapp/utils/colors.dart';
import 'package:instacloneapp/utils/utils.dart';

import '../widgest/text_field_inputs.dart';


class SignupScreen extends StatefulWidget {

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailTextEditingController = TextEditingController();

  final TextEditingController passwordTextEditingController = TextEditingController();

  final TextEditingController bioTextEditingController = TextEditingController();

  final TextEditingController usernameTextEditingController = TextEditingController();

  Uint8List? _img;

  bool _isLoading = false;

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    bioTextEditingController.dispose();
    usernameTextEditingController.dispose();
    super.dispose();
  }


  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _img = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });


    // signup user using our authmethodds
    String res = await AuthMethods().signupUser(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
        username: usernameTextEditingController.text,
        bio: bioTextEditingController.text,
        file: _img!);

    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen

      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout()
        ),
            ),
        );
      }
    }}



    void navigateToLogin(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
                  _img != null ? CircleAvatar(
              radius: 64,
                backgroundImage: MemoryImage(_img!)
              )
                  : CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                      "https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2281862025.jpg"
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: (){
                          selectImage();
                        },
                        icon: Icon(Icons.add_a_photo),
                      ))
                ],
              ),
              const SizedBox(height: 24,),

              TextFieldInput(
                hintText: "enter your username",
                textInputType: TextInputType.text,
                textEditingController: usernameTextEditingController,

              ),
              const SizedBox(height: 24,),
              TextFieldInput(
                hintText: "enter your bio",
                textInputType: TextInputType.text,
                textEditingController: bioTextEditingController,
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
                onTap: signUpUser,
                child: Container(
                  child: _isLoading ?
                  Center(child: CircularProgressIndicator(
                    color: primaryColor,
                  ),)
                      : const Text("Sign up")  ,
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
              Flexible(flex: 2,child: Container(),),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account?",
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: Text("Login",style: TextStyle(
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
