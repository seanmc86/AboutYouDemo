import 'package:AboutYouDemo/Blocs/BlocProvider.dart';
import 'package:AboutYouDemo/Blocs/FilterBloc.dart';
import 'package:AboutYouDemo/Blocs/ProductBloc.dart';

class AppBloc implements BlocBase {
  ProductBloc _productBloc;
  FilterBloc _filterBloc;

  AppBloc() {
    _productBloc = ProductBloc();
    _filterBloc = FilterBloc();
  }

  ProductBloc get productBloc => _productBloc;
  FilterBloc get filterBloc => _filterBloc;

  @override
  void dispose() {
    print('Disposing blocs');
    _productBloc.dispose();
    _filterBloc.dispose();
  }
}