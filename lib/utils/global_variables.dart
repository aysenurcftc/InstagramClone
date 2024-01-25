import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instacloneapp/screens/add_post_screen.dart';
import 'package:instacloneapp/screens/feed_screen.dart';
import 'package:instacloneapp/screens/profile_screen.dart';
import 'package:instacloneapp/screens/search_screen.dart';


const webScreenSize = 600;

List<Widget> homeScreenItems = [

  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("hello"),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),

];