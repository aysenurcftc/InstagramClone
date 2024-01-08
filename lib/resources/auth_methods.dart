


import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instacloneapp/resources/storage_methods.dart';

class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // sign up user
  Future<String> signupUser ({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,

      }) async{

        String res = "Some error occured!";
        try{

          if (Firebase.apps.isEmpty) {
            await Firebase.initializeApp();
          }


          if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || file != null){

            //register user
            UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
            print(cred.user!.uid);
            
            String photoUrl = await StorageMethods().uploadImageToStorage("profilePics", file, false);

            //add user to database
            await _firestore.collection("users").doc(cred.user!.uid).set({
              'username' : username,
              'uid' : cred.user!.uid,
              'email' : email,
              'bio' : bio,
              'followers' : [],
              'following' : [],
              'photoUrl' : photoUrl,
            });


            res = "success";
          }
        }

        catch(err){
          print('Hata yakalandı: $err');
          res = err.toString();
        }
        return res;

  }


  //login in user

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured!";

    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";

      }
      else{
        res = "Please enter all the fields";
      }

    }
    catch(err){
      res = err.toString();
    }
    return res;

  }





}