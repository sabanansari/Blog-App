import 'package:blog_app/photoUpload.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';

class HomePage extends StatefulWidget {
  final Authentication auth;
  final VoidCallback onSignedOut;

  HomePage({this.auth, this.onSignedOut});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  logOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(),
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
                  Icons.local_car_wash,
                ),
                iconSize: 50,
                color: Colors.white,
                onPressed: logOut,
              ),
              IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                ),
                iconSize: 50,
                color: Colors.white,
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
}
