import 'package:AboutYouDemo/Blocs/AppBloc.dart';
import 'package:AboutYouDemo/Blocs/BlocProvider.dart';
import 'package:AboutYouDemo/Components/SubmitButton.dart';
import 'package:AboutYouDemo/Components/TitleWidget.dart';
import 'package:AboutYouDemo/Screens/FilterMenu/ColorSection.dart';
import 'package:AboutYouDemo/Screens/FilterMenu/PricingSection.dart';
import 'package:AboutYouDemo/Styles/Constants.dart';
import 'package:AboutYouDemo/Helpers/StringLocalizations.dart';
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
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    return Drawer(
        child: Scaffold(
            body: Container(
                color: Constants.mColorThemeSecondary[100],
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TitleWidget(title: StringLocalizations.filterTitle),
                    PricingSection(),
                    SizedBox(height: Dimensions.large),
                    ColorSection(),
                    SubmitButton(
                      title: StringLocalizations.filterButtonText,
                      onPressed: () {
                        appBloc.productBloc.inActiveFilters.add(appBloc.filterBloc.getFilters);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ))));
  }
}
