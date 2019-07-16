import 'package:AboutYouDemo/Styles/Constants.dart';
import 'package:AboutYouDemo/Styles/Dimensions.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.stylePaddingXXS,
                    right: Dimensions.stylePaddingXXS,
                    bottom: Dimensions.stylePaddingXXS,
                  ),
                  child: FlatButton(
                      child: Icon(Icons.arrow_back,
                          color: Constants.mColorThemePrimary[900]),
                      color: Constants.mColorThemePrimary[50],
                      highlightColor: Colors.green,
                      onPressed: () => Navigator.pop(context))),
            backgroundColor: Constants.mColorThemePrimary[50],
        ),
        body: Center(child: Container(child: Text('Settings Page'), color: Constants.mColorThemePrimary[50])),
        resizeToAvoidBottomPadding: false,
        backgroundColor: Constants.mColorThemePrimary[50],
    );
  }
}