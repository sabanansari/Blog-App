import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'authentication.dart';

class MappingPage extends StatefulWidget {
  final Authentication authenticate;

  MappingPage({
    this.authenticate,
  });
  @override
  _MappingPageState createState() => _MappingPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    widget.authenticate.getCurrentUser().then((firebaseUserId) {
      setState(() {
        authStatus = firebaseUserId == null
            ? AuthStatus.notSignedIn
            : AuthStatus.signedIn;
      });
    });
    super.initState();
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginAndRegister(
          auth: widget.authenticate,
          onSignedIn: _signedIn,
        );

      case AuthStatus.signedIn:
        return HomePage(
          auth: widget.authenticate,
          onSignedOut: _signedOut,
        );
    }
  }
}
