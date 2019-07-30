import 'package:AboutYouDemo/Styles/Dimensions.dart';
import 'package:AboutYouDemo/Styles/LayoutTheme.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  TitleWidget({@required this.title});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
        padding: EdgeInsets.all(Dimensions.stylePaddingL),
        child: Text(title,
            textAlign: TextAlign.left,
            style: LayoutThemeContainer.of(context).titleBold(theme)));
  }
}
