import 'package:AboutYouDemo/Blocs/AppBloc.dart';
import 'package:AboutYouDemo/Blocs/BlocProvider.dart';
import 'package:flutter/material.dart';
import 'package:AboutYouDemo/Styles/Constants.dart';
import 'package:AboutYouDemo/Styles/LayoutTheme.dart';
import 'package:AboutYouDemo/Helpers/StringLocalizations.dart';
import 'package:AboutYouDemo/Routes/Routes.dart';
import 'package:AboutYouDemo/Screens/Home/Home.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme baseTextTheme = Theme.of(context).textTheme;
    return LayoutThemeContainer(
        child: MaterialApp(
      title: StringLocalizations.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Constants.mColorThemePrimary[800],
          primarySwatch: Constants.mColorThemePrimary,
          primaryColorLight: Constants.primaryLightColor,
          primaryColorDark: Constants.primaryDarkColor,
          secondaryHeaderColor: Constants.secondaryColor,
          backgroundColor: Constants.backgroundColor,
          cardColor: Constants.backgroundColor,
          canvasColor: Constants.mColorThemePrimary[200],
          textTheme: CustomTextTheme.textTheme(baseTextTheme)),
      home: Home(),
      routes: Routes.appRoutes,
    ));
  }
}

Future<void> main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  return runApp(
    BlocProvider<AppBloc>(
      bloc: AppBloc(),
      child: MyApp(),
    )
  );
}