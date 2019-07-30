import 'package:AboutYouDemo/Helpers/Enums.dart';
import 'package:AboutYouDemo/Screens/FilterMenu/ColorTile.dart';
import 'package:AboutYouDemo/Styles/Dimensions.dart';
import 'package:flutter/material.dart';

class ColorSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(Dimensions.stylePaddingS),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ColorTile(colorType: ColorType.black),
                      ColorTile(colorType: ColorType.white),
                      ColorTile(colorType: ColorType.gray),
                    ])),
            Padding(
                padding: EdgeInsets.all(Dimensions.stylePaddingS),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ColorTile(colorType: ColorType.blue),
                      ColorTile(colorType: ColorType.pink),
                    ])),
          ]);
  }
}
