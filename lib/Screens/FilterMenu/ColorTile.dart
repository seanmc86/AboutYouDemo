import 'package:AboutYouDemo/Blocs/AppBloc.dart';
import 'package:AboutYouDemo/Blocs/BlocProvider.dart';
import 'package:AboutYouDemo/Styles/Constants.dart';
import 'package:AboutYouDemo/Helpers/Enums.dart';
import 'package:AboutYouDemo/Styles/LayoutTheme.dart';
import 'package:AboutYouDemo/Helpers/StringLocalizations.dart';
import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget {
  final ColorType colorType;

  ColorTile({@required this.colorType});

  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    final ThemeData theme = Theme.of(context);
    return StreamBuilder(
        stream: appBloc.filterBloc.outColorFilters,
        builder: (context, colorSnapshot) {
          List<ColorType> colorList = List<ColorType>();
          if (colorSnapshot.data != null) colorList = colorSnapshot.data;
          return GestureDetector(
              onTap: () {
                colorList.contains(colorType)
                    ? colorList.remove(colorType)
                    : colorList.add(colorType);
                appBloc.filterBloc.inColorFilters.add(colorList);
              },
              child: Column(
                children: <Widget>[
                ClipOval(
                    child: Container(
                        width: 50.0,
                        height: 50.0,
                        color: StringLocalizations.filterColorMap[colorType],
                        child: Icon(
                            colorList.contains(colorType) ? Icons.check : null,
                            color: colorType == ColorType.white
                                ? Constants.materialBlack
                                : Constants.materialWhite))),
                Text(StringLocalizations.filterColorStringMap[colorType],
                    textAlign: TextAlign.left,
                    style: LayoutThemeContainer.of(context).titleThin(theme)),
              ]));
        });
  }
}
