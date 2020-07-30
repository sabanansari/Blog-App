import 'package:flutter/material.dart';

class LoginAndRegister extends StatefulWidget {
  @override
  _LoginAndRegisterState createState() => _LoginAndRegisterState();
}

enum FormType { login, register }

class _LoginAndRegisterState extends State<LoginAndRegister> {
  var formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Blog App"),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
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
        validator: (value) {
          return value.isEmpty ? "Email is required" : null;
        },
        onSaved: (value) {
          return _email = value;
        },
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'Password'),
        validator: (value) {
          return value.isEmpty ? "Password is required" : null;
        },
        onSaved: (value) {
          return _password = value;
        },
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
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          child: Text(
            'Register',
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
            "Already have an Account? Click here to Login",
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          textColor: Colors.blue,
          onPressed: moveToLogin,
        )
      ];
    } else {
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
          textColor: Colors.red,
          onPressed: moveToRegister,
        )
      ];
    }
  }
}
