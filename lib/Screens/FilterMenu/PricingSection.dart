import 'package:AboutYouDemo/Blocs/AppBloc.dart';
import 'package:AboutYouDemo/Blocs/BlocProvider.dart';
import 'package:AboutYouDemo/Components/RectangularButton.dart';
import 'package:AboutYouDemo/Helpers/StringLocalizations.dart';
import 'package:flutter/material.dart';

class PricingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    return StreamBuilder(
        stream: appBloc.filterBloc.outPriceFilters,
        builder: (context, priceSnapshot) {
          return Column(children: <Widget>[
            RectangularButton(
                key: Key('priceup'),
                colorActive:
                    priceSnapshot.data == null ? false : priceSnapshot.data,
                title: StringLocalizations.filterPriceHighest,
                onPressed: () =>
                    priceSnapshot.data == false || priceSnapshot.data == null
                        ? appBloc.filterBloc.inPriceFilters.add(true)
                        : appBloc.filterBloc.inPriceFilters.add(null)),
            RectangularButton(
                key: Key('pricedown'),
                colorActive:
                    priceSnapshot.data == null ? false : !priceSnapshot.data,
                title: StringLocalizations.filterPriceLowest,
                onPressed: () =>
                    priceSnapshot.data == true || priceSnapshot.data == null
                        ? appBloc.filterBloc.inPriceFilters.add(false)
                        : appBloc.filterBloc.inPriceFilters.add(null)),
          ]);
        });
  }
}
