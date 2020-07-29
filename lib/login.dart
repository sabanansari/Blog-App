import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void validateAndSave() {}
  void moveToRegister() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Blog App"),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButton(),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 12.0,
      ),
      logo(),
      SizedBox(
        height: 15.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget logo() {
    return Hero(
      tag: 'logo',
      child: CircleAvatar(
        radius: 110.0,
        child: Image.asset('images/blog.png'),
      ),
    );
  }

  List<Widget> createButton() {
    return [
      RaisedButton(
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        textColor: Colors.white,
        color: Colors.lightBlueAccent,
        onPressed: validateAndSave,
      ),
      FlatButton(
        child: Text(
          "Don't have an Account? Click to Create Account",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: moveToRegister,
      )
    ];
  }
}
