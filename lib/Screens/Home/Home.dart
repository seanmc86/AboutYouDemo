import 'package:AboutYouDemo/Blocs/AppBloc.dart';
import 'package:AboutYouDemo/Blocs/BlocProvider.dart';
import 'package:AboutYouDemo/Screens/Settings/Settings.dart';
import 'package:AboutYouDemo/Styles/Constants.dart';
import 'package:AboutYouDemo/Styles/LayoutTheme.dart';
import 'package:AboutYouDemo/Blocs/FilterBloc.dart';
import 'package:AboutYouDemo/Screens/FilterMenu/FilterMenu.dart';
import 'package:AboutYouDemo/Screens/Home/ProductTile.dart';
import 'package:flutter/material.dart';
import 'package:AboutYouDemo/Helpers/StringLocalizations.dart';
import 'package:AboutYouDemo/Styles/Dimensions.dart';

class Home extends StatefulWidget {
  //TODO: Explore as a StatelessWidget in future. Some benefits using Stateful still when incorporating
  //scroll listening
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _gridViewScroller = ScrollController();

  @override
  void initState() {
    addScrollListener();
    super.initState();
  }

  // ### Starts loading new products when you're 0.6x the width away from the bottom of the scroll area
  void addScrollListener() {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    _gridViewScroller.addListener(() async {
      if (_gridViewScroller.offset >=
              _gridViewScroller.position.maxScrollExtent -
                  MediaQuery.of(context).size.width * 0.6 &&
          !_gridViewScroller.position.outOfRange &&
          _gridViewScroller.offset != 0.0) {
        await appBloc.productBloc.updateProductList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        key: _scaffoldKey,
        //TODO: Strip this out to another class maybe... And standardise text fields
        appBar: AppBar(
            backgroundColor: Constants.mColorThemePrimary[50],
            centerTitle: false,
            title: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
              Container(
                  color: Constants.mColorThemePrimary[900],
                  child: Text(StringLocalizations.appTitleFirst,
                      textAlign: TextAlign.left,
                      style:
                          LayoutThemeContainer.of(context).appbarTitle(theme))),
              SizedBox(width: Dimensions.stylePaddingXXS),
              Container(
                  color: Constants.mColorThemePrimary[900],
                  child: Text(StringLocalizations.appTitleSecond,
                      textAlign: TextAlign.left,
                      style:
                          LayoutThemeContainer.of(context).appbarTitle(theme))),
              Expanded(
                  child: Container(
                      color: Constants.mColorThemePrimary[50],
                      child: Padding(
                          padding:
                              EdgeInsets.only(left: Dimensions.stylePaddingXXS),
                          child: Text(StringLocalizations.appSubtitle,
                              textAlign: TextAlign.left,
                              style: LayoutThemeContainer.of(context)
                                  .titleThinBlack(theme)))))
            ]),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                    right: Dimensions.stylePaddingXXS,
                    bottom: Dimensions.stylePaddingXXS,
                  ),
                  child: FlatButton(
                      child: Icon(Icons.settings,
                          color: Constants.mColorThemePrimary[900]),
                      color: Constants.mColorThemePrimary[50],
                      highlightColor: Colors.green,
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Settings()),
                          ))),
              Padding(
                padding: EdgeInsets.only(
                  right: Dimensions.stylePaddingXXS,
                  bottom: Dimensions.stylePaddingXXS,
                ),
                child: FlatButton(
                    key: Key('opendrawer'),
                    child: Icon(Icons.filter_list,
                        color: Constants.mColorThemePrimary[900]),
                    color: Constants.mColorThemePrimary[50],
                    highlightColor: Colors.green,
                    onPressed: () => _scaffoldKey.currentState.openEndDrawer()),
              )
            ]),
        resizeToAvoidBottomPadding: false,
        backgroundColor: Constants.mColorThemePrimary[50],
        endDrawer: BlocProvider<FilterBloc>(
          bloc: appBloc.filterBloc,
          child: FilterMenu(),
        ),
        body: StreamBuilder(
            stream: appBloc.productBloc.outProductList,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return textError(snapshot.error.toString());

              if (snapshot.hasData) {
                if (snapshot.data.length == 0)
                  return Center(child: CircularProgressIndicator());

                if (snapshot.data.length <= 10 && _gridViewScroller.hasClients)
                  _gridViewScroller.animateTo(0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.bounceOut);
              }
              return gridView(context, snapshot);
            }));
  }

  Widget textError(String title) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text(title.isNotEmpty
              ? title
              : 'No products could be found! Please try refreshing...'),
          SizedBox(height: Dimensions.large),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: appBloc.productBloc.resetState,
          )
        ]));
  }

  Widget gridView(BuildContext context, AsyncSnapshot snapshot) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    Widget gridBuilder = RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: appBloc.productBloc.resetState,
        child: !snapshot.hasData
            ? Center(child: CircularProgressIndicator())
            : snapshot.hasError
                ? Center(
                    child: FlatButton.icon(
                      icon: Icon(Icons.refresh),
                      label: Text(StringLocalizations.retryText),
                      onPressed: appBloc.productBloc.resetState,
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: Dimensions.stylePaddingS,
                      crossAxisSpacing: Dimensions.stylePaddingS,
                    ),
                    controller: _gridViewScroller,
                    primary: false,
                    padding: EdgeInsets.only(
                        left: Dimensions.stylePaddingS,
                        right: Dimensions.stylePaddingS,
                        top: Dimensions.stylePaddingS,
                        bottom: 0.0),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductTile(product: snapshot.data[index]);
                    }));

    return gridBuilder;
  }
}
