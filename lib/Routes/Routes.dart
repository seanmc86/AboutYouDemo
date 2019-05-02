import 'package:flutter/material.dart';
import 'package:AboutYouDemo/Screens/Home/Home.dart';

class Routes {
  Routes();
  static const String loginPage = '/login-page';
  static const String homePage = '/home-page';
  static const String projectPage = '/project-page';
  static const String taskPage = '/task-page';

  static final appRoutes = {
    //Routes.loginPage: (BuildContext context) => LoginPage(),
    Routes.homePage: (BuildContext context) => Home()
  };
}