import 'package:AboutYouDemo/Styles/Constants.dart';
import 'package:AboutYouDemo/Helpers/Enums.dart';
import 'package:AboutYouDemo/Styles/LayoutTheme.dart';
import 'package:AboutYouDemo/Helpers/StringLocalizations.dart';
import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color color;
  final bool selected;

  ColorTile(
      {this.title, this.onTap, this.color, this.selected});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
        onTap: onTap,
        child: Column(children: <Widget>[
          ClipOval(
              child: Container(
            width: 50.0,
            height: 50.0,
            color: color,
            child: Icon(
              selected
                ? Icons.check
                : null,
              color: color == StringLocalizations.filterColorMap[ColorType.white]
                ? Constants.materialBlack
                : Constants.materialWhite
            )
          )),
          Text(title,
              textAlign: TextAlign.left,
              style: LayoutThemeContainer.of(context).titleThin(theme)),
        ]));
  }
}
