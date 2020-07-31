import 'package:blog_app/photoUpload.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'posts.dart';

class HomePage extends StatefulWidget {
  final Authentication auth;
  final VoidCallback onSignedOut;

  HomePage({this.auth, this.onSignedOut});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts> postsList = [];

  logOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var datas = snapshot.value;

      postsList.clear();
      for (var individualKey in keys) {
        Posts posts = Posts(
          datas[individualKey]['image'],
          datas[individualKey]['description'],
          datas[individualKey]['date'],
          datas[individualKey]['time'],
          datas[individualKey]['userEmail'],
        );

        postsList.add(posts);
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: postsList.length == 0
            ? Text('No blog to display')
            : ListView.builder(
                itemCount: postsList.length,
                itemBuilder: (_, index) {
                  return postsDesign(
                    postsList[index].image,
                    postsList[index].description,
                    postsList[index].date,
                    postsList[index].time,
                    postsList[index].userEmail,
                  );
                }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        child: Container(
          margin: EdgeInsets.only(left: 80.0, right: 80.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30.0,
                ),
                onPressed: logOut,
              ),
              IconButton(
                icon: Icon(
                  Icons.add_photo_alternate,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UploadPhotoPage();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget postsDesign(String image, String description, String date, String time,
      String userEmail) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                date,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
              Text(
                userEmail == null ? '' : userEmail,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Image.network(
            image,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
