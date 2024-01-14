


import 'package:flutter/material.dart';
import 'package:instacloneapp/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,

            ).copyWith(right: 0),
            child:  Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    "https://www.arkhesanat.com/dosyalar/2019/04/arkhe-sanat-akademisi-resim-is-ogretmenligi-01.jpg",
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            Text("username", style: TextStyle(
                              fontWeight: FontWeight.bold,

                            ),)
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                  showDialog(context: context, builder: (context) => Dialog(
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shrinkWrap: true,
                      children: [
                        "delete"
                      ].map((e) => InkWell(
                        onTap: (){},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: Text(e),
                        ),
                      ),
                      ).toList(),
                    ),
                  ),
                  );
                    },
                    icon: Icon(Icons.more_vert))
              ],
            ),

          ),
          //Image Section
          SizedBox(
            height: MediaQuery.of(context).size.height*0.35,
            width: double.infinity,
            child: Image.network(
              "https://www.sanathane.art/upload/product/resim-kursu-1-20180809141821-20201004002615.jpg",
              fit: BoxFit.cover,
            ),

          ),

          //Like comment section
          Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite, color: Colors.red,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.comment_outlined,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.send,)),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(Icons.bookmark_border),
                    onPressed: (){},
                  ),
                ),
              )
            ],
          ),

          //description and number of comments

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                      child: Text(
                        "1.455 likes",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: "username",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "this is description",
                        )
                      ]
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text("view all 200 comments", style: TextStyle(
                      fontSize: 16,
                      color: secondaryColor,
                    ),),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text("15/01/2024", style: TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
                  ),),
                ),


              ],
            ),
          ),



        ],
      ),
    );
  }
}
