import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:videochat/authentication/authentication.dart';
import 'package:videochat/navigation_home_screen.dart';
//import 'package:poc1/homelist.dart';

import 'package:videochat/authentication/email_login.dart';
import 'package:videochat/authentication/email_signup.dart';

class SignUp extends StatelessWidget {
  final String title = "Videochat Signup";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Videochat Signup",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Roboto')),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Email,
                  text: "Sign up with Email",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailSignUp()),
                    );
                  },
                )),
            FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error Initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orange,
                    ),
                  );
                }),
/*            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Twitter,
                  text: "Sign up with Twitter",
                  onPressed: () {},
                )),
*/
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButtonBuilder(
                  text: "Sign in Anonymously",
                  icon: Icons.cake,
                  onPressed: () {},
                  backgroundColor: Colors.blueGrey[700]!,
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                    child: Text("Log In Using Email",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmailLogIn()),
                      );
                    }))
          ]),
        ));
  }
}

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: _isSigningIn
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () async {
                  setState(() {
                    _isSigningIn = true;
                  });

                  User? user =
                      await Authentication.signInWithGoogle(context: context);
                  // TODO: set call to sign in

                  setState(() {
                    _isSigningIn = false;
                  });

                  if (user != null) {
                    await FirebaseChatCore.instance.createUserInFirestore(
                      types.User(
                          firstName: user.displayName,
                          id: user.uid,
                          imageUrl: user.photoURL,
                          lastName: user.displayName),
                    );

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => NavigationHomeScreen(),
//                        builder: (context) => HomeList(
//                          user: user,
//                        ),
                      ),
                    );
                  }
                },
              )
/*
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user =
                    await Authentication.signInWithGoogle(context: context);
                // TODO: set call to sign in

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => UserInfoScreen(
                        user: user,
                      ),
                    ),
                  );
                }
              },
              child: Padding(
                //padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                padding: EdgeInsets.zero,
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SignInButton(
                        Buttons.Google,
                        text: "Sign in with Google",
                        onPressed: () {},
                      )
                    ]

                    /*
                  children: <Widget>[
                    Image(
                        image: AssetImage("assets/images/google_logo.png"),
                        height: 35.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                  */
                    ),
              ),
            ),
            */
        );
  }
}
