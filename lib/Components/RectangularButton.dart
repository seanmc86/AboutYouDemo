import 'package:AboutYouDemo/Styles/Constants.dart';
import 'package:AboutYouDemo/Styles/LayoutTheme.dart';
import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  final Function onPressed;
  final bool colorActive;
  final String title;

  RectangularButton(
      {@required this.onPressed,
      @required this.colorActive,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FlatButton(
        onPressed: onPressed,
        color: colorActive
            ? Constants.mColorThemePrimary[400]
            : Constants.materialWhite,
        splashColor: Constants.materialWhite,
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Text(title,
              textAlign: TextAlign.center,
              style: LayoutThemeContainer.of(context).titleThin(theme)),
        ));
  }
}
