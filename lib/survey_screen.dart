import 'package:flutter_signin_button/button_builder.dart';
import 'package:videochat/app_theme.dart';
import 'package:flutter/material.dart';
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
  bool multiple = true;
  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: appBar2(),
            backgroundColor: Colors.white,
            elevation: 0,
          )),
      backgroundColor: AppTheme.white,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //appBar(),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 20.0),
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
        },
      ),
    );
  }

  Widget appBar2() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          const Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Seeker Survey',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 0),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: AppTheme.dark_grey,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
