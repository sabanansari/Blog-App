import 'package:blog_app/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File _sampleImage;
  final picker = ImagePicker();
  var formKey = GlobalKey<FormState>();
  String _myvalue;
  String url;

  Future getImage() async {
    final tempImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _sampleImage = File(tempImage.path);
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("Post Images");

      var timeKey = DateTime.now();
      final StorageUploadTask uploadTask =
          postImageRef.child(timeKey.toString() + ".jpg").putFile(_sampleImage);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      url = imageUrl.toString();

      goToHomePage();
      saveToDatabase(url);
    }
  }

  saveToDatabase(url) {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');
    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

    var data = {
      'image': url,
      'description': _myvalue,
      'date': date,
      'time': time,
    };
    databaseReference.child('Posts').push().set(data);
  }

  goToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
        centerTitle: true,
      ),
      body: Center(
        child: _sampleImage == null ? Text("Select an image") : uploadPhoto(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add Image",
        child: Icon(
          Icons.add_a_photo,
          size: 30.0,
        ),
      ),
    );
  }

  Widget uploadPhoto() {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(
              _sampleImage,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            SizedBox(
              height: 15.0,
            ),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Caption it',
                ),
                validator: (value) {
                  return value.isEmpty ? 'Description is required' : null;
                },
                onSaved: (value) {
                  return _myvalue = value;
                },
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              elevation: 10.0,
              child: Text('Add a New Post'),
              textColor: Colors.lightBlueAccent,
              onPressed: uploadStatusImage,
            )
          ],
        ),
      ),
    );
  }
}
