import 'package:firebase_auth/firebase_auth.dart';
import 'package:videochat/app_theme.dart';
import 'package:videochat/custom_drawer/drawer_user_controller.dart';
import 'package:videochat/custom_drawer/home_drawer.dart';
import 'package:videochat/survey_screen.dart';
import 'package:videochat/help_screen.dart';
import 'package:videochat/home_screen.dart';
import 'package:videochat/invite_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:videochat/buy_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  late User _user;
  @override
  void initState() {
    _user = widget._user;
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            user: _user,
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Survey) {
        setState(() {
          screenView = SurveyScreen(user: _user);
        });
      } else if (drawerIndex == DrawerIndex.Buy) {
        setState(() {
          screenView = BuyScreen(user: _user);
        });
      } else if (drawerIndex == DrawerIndex.Sell) {
        setState(() {
          screenView = InviteFriend();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = InviteFriend();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = InviteFriend();
        });
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          screenView = InviteFriend();
        });
      } else {
        //do in your way......
      }
    }
  }
}
