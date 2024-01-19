import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instacloneapp/providers/user_provider.dart';
import 'package:instacloneapp/resources/firestore_methods.dart';
import 'package:instacloneapp/utils/colors.dart';
import 'package:instacloneapp/widgest/commets_card.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class CommentsScreen extends StatefulWidget {

  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {


  final TextEditingController  _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<UserProvider>(context).getUser;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comments"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap["postId"])
            .collection('comments')
            .orderBy("datePublished",descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => CommentCard(
              snap: (snapshot.data! as dynamic).docs[index].data(),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child:  Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    user.photoUrl
                ),
                radius: 16,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Comment as ${user.username}",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: () async{
                  await FireStoreMethods().postComment(widget.snap["postId"], _commentController.text, user.uid, user.username, user.photoUrl);
               setState(() {
                 _commentController.text = "";
               });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    "Posts",
                    style: TextStyle(
                      color: Colors.blueAccent,

                    ),

                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );

  }
}
