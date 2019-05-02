import 'package:flutter/material.dart';
import 'package:AboutYouDemo/Styles/Constants.dart';

class LayoutThemeContainer extends StatefulWidget {
  const LayoutThemeContainer({Key key, this.child}) : super(key: key);

  final Widget child;

  static LayoutThemeState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  LayoutThemeState createState() => LayoutThemeState();
}

class LayoutThemeState extends State<LayoutThemeContainer> {
  /// Text theme overrides

  TextStyle appbarTitle(ThemeData theme) {
    return theme.textTheme.title.copyWith(
        fontSize: Constants.fontSizeAppbarTitle,
        color: Constants.themeForegroundLight);
  }

  TextStyle titleBold(ThemeData theme) {
    return theme.textTheme.subhead.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: Constants.fontSizeAppbarTitle,
      color: Constants.materialBlack);
  }

  TextStyle titleThin(ThemeData theme) {
    return theme.textTheme.subhead.copyWith(
      fontWeight: FontWeight.w400,
      color: Constants.materialBlack);
  }

  TextStyle titleThinBlack(ThemeData theme) {
    return theme.textTheme.subhead.copyWith(
      fontWeight: FontWeight.w400,
      color: Constants.primaryDarkColor);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final LayoutThemeState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class CustomTextTheme {
  /// Text theme
  static TextTheme textTheme(TextTheme base) {
    return base
        .copyWith(
            subhead: base.subhead.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: Constants.fontSizeSubhead),
            title: base.title.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Constants.fontSizeTitle),
            caption: base.caption.copyWith(fontSize: Constants.fontSizeSubhead),
            button: base.button.copyWith(
                fontSize: Constants.fontSizeButton,
                fontWeight: FontWeight.w800))
        .apply(
          fontFamily: 'Futura'
        );
  }
}