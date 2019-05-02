import 'package:AboutYouDemo/Blocs/BlocProvider.dart';
import 'package:AboutYouDemo/Styles/Constants.dart';
import 'package:AboutYouDemo/Helpers/Enums.dart';
import 'package:AboutYouDemo/Styles/LayoutTheme.dart';
import 'package:AboutYouDemo/Helpers/StringLocalizations.dart';
import 'package:AboutYouDemo/Screens/FilterMenu/ColorTile.dart';
import 'package:AboutYouDemo/Blocs/FilterBloc.dart';
import 'package:AboutYouDemo/Blocs/ProductBloc.dart';
import 'package:AboutYouDemo/Styles/Dimensions.dart';
import 'package:flutter/material.dart';

class FilterMenu extends StatefulWidget {
  //TODO: Explore as a StatelessWidget in future. Current benefit of Stateful with button highlights etc,
  //but this can eventually be added to blocs as well.
  @override
  _FilterMenuState createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  @override
  Widget build(BuildContext context) {
    final ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);
    final FilterBloc filterBloc = BlocProvider.of<FilterBloc>(context);
    final ThemeData theme = Theme.of(context);
    //TODO: Create separate widget classes for all of these children to reduce clutter
    return Drawer(
        child: Scaffold(
            body: StreamBuilder(
                stream: filterBloc.outPriceFilters,
                builder: (context, priceSnapshot) {
                  return Container(
                      color: Constants.mColorThemeSecondary[100],
                      child: StreamBuilder(
                          stream: filterBloc.outColorFilters,
                          builder: (context, colorSnapshot) {
                            List<ColorType> colors = List<ColorType>();
                            if (colorSnapshot.data != null)
                              colors = colorSnapshot.data;
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.stylePaddingL),
                                    child: Text(StringLocalizations.filterTitle,
                                        textAlign: TextAlign.left,
                                        style: LayoutThemeContainer.of(context)
                                            .titleBold(theme))),
                                FlatButton(
                                    onPressed: () => priceSnapshot.data == false || priceSnapshot.data == null
                                        ? filterBloc.inPriceFilters.add(true)
                                        : filterBloc.inPriceFilters.add(null),
                                    color: priceSnapshot.data == null
                                        ? Constants.materialWhite
                                        : priceSnapshot.data
                                            ? Constants.mColorThemePrimary[400]
                                            : Constants.materialWhite,
                                    splashColor: Constants.materialWhite,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text(
                                          StringLocalizations
                                              .filterPriceHighest,
                                          textAlign: TextAlign.center,
                                          style:
                                              LayoutThemeContainer.of(context)
                                                  .titleThin(theme)),
                                    )),
                                FlatButton(
                                    onPressed: () => priceSnapshot.data == true || priceSnapshot.data == null
                                        ? filterBloc.inPriceFilters.add(false)
                                        : filterBloc.inPriceFilters.add(null),
                                    color: priceSnapshot.data == null
                                        ? Constants.materialWhite
                                        : !priceSnapshot.data
                                            ? Constants.mColorThemePrimary[400]
                                            : Constants.materialWhite,
                                    splashColor: Constants.materialWhite,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text(
                                          StringLocalizations.filterPriceLowest,
                                          textAlign: TextAlign.center,
                                          style:
                                              LayoutThemeContainer.of(context)
                                                  .titleThin(theme)),
                                    )),
                                SizedBox(height: Dimensions.large),
                                Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.stylePaddingS),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          ColorTile(
                                              title: StringLocalizations
                                                      .filterColorStringMap[
                                                  ColorType.black],
                                              selected: colors
                                                  .contains(ColorType.black),
                                              onTap: () {
                                                colors.contains(ColorType.black)
                                                    ? colors
                                                        .remove(ColorType.black)
                                                    : colors
                                                        .add(ColorType.black);
                                                filterBloc.inColorFilters
                                                    .add(colors);
                                              },
                                              color: StringLocalizations
                                                      .filterColorMap[
                                                  ColorType.black]),
                                          ColorTile(
                                              title: StringLocalizations
                                                      .filterColorStringMap[
                                                  ColorType.white],
                                              selected: colors
                                                  .contains(ColorType.white),
                                              onTap: () {
                                                colors.contains(ColorType.white)
                                                    ? colors
                                                        .remove(ColorType.white)
                                                    : colors
                                                        .add(ColorType.white);
                                                filterBloc.inColorFilters
                                                    .add(colors);
                                              },
                                              color: StringLocalizations
                                                      .filterColorMap[
                                                  ColorType.white]),
                                          ColorTile(
                                              title: StringLocalizations
                                                      .filterColorStringMap[
                                                  ColorType.gray],
                                              selected: colors
                                                  .contains(ColorType.gray),
                                              onTap: () {
                                                colors.contains(ColorType.gray)
                                                    ? colors
                                                        .remove(ColorType.gray)
                                                    : colors
                                                        .add(ColorType.gray);
                                                filterBloc.inColorFilters
                                                    .add(colors);
                                              },
                                              color: StringLocalizations
                                                      .filterColorMap[
                                                  ColorType.gray])
                                        ])),
                                Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.stylePaddingS),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          ColorTile(
                                              title: StringLocalizations
                                                      .filterColorStringMap[
                                                  ColorType.blue],
                                              selected: colors
                                                  .contains(ColorType.blue),
                                              onTap: () {
                                                colors.contains(ColorType.blue)
                                                    ? colors
                                                        .remove(ColorType.blue)
                                                    : colors
                                                        .add(ColorType.blue);
                                                filterBloc.inColorFilters
                                                    .add(colors);
                                              },
                                              color: StringLocalizations
                                                      .filterColorMap[
                                                  ColorType.blue]),
                                          ColorTile(
                                              title: StringLocalizations
                                                      .filterColorStringMap[
                                                  ColorType.pink],
                                              selected: colors
                                                  .contains(ColorType.pink),
                                              onTap: () {
                                                colors.contains(ColorType.pink)
                                                    ? colors
                                                        .remove(ColorType.pink)
                                                    : colors
                                                        .add(ColorType.pink);
                                                filterBloc.inColorFilters
                                                    .add(colors);
                                              },
                                              color: StringLocalizations
                                                      .filterColorMap[
                                                  ColorType.pink]),
                                        ])),
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Dimensions.stylePaddingM),
                                        child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: FlatButton(
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Text(
                                                    StringLocalizations
                                                        .filterButtonText,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              color: Constants.materialBlack,
                                              splashColor:
                                                  Constants.materialWhite,
                                              textColor: Constants
                                                  .mColorThemePrimary[50],
                                              onPressed: () {
                                                productBloc.inActiveFilters
                                                    .add(filterBloc.getFilters);
                                                Navigator.pop(context);
                                              },
                                            )))),
                              ],
                            );
                          }));
                })));
  }
}
