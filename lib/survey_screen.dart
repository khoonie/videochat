import 'package:flutter_signin_button/button_builder.dart';
import 'package:videochat/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:videochat/survey.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  late User _user;
  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Seeker Survey",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'Roboto')),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
                "This survey will gather information to help us to better understand and recommend the properties you seek",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Roboto')),
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
              child: SignInButtonBuilder(
                icon: Icons.content_paste_outlined,
                text: 'Click to Start Survey',
                backgroundColor: Colors.blueGrey,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SeekerSurvey(
                                user: _user,
                              ))).then((value) {
                    print(value);
                  });
                },
              )),
        ],
      ),
    );
  }
}
