import 'dart:async';
import 'package:AboutYouDemo/Blocs/BlocProvider.dart';
import 'package:AboutYouDemo/Helpers/Enums.dart';
import 'package:rxdart/rxdart.dart';

class FilterBloc implements BlocBase {

  // Price order selection interfaces
  BehaviorSubject<bool> _price$ = BehaviorSubject<bool>();
  Sink<bool> get inPriceFilters => _price$.sink;
  Stream<bool> get outPriceFilters => _price$.stream;

  // Color selection interfaces
  BehaviorSubject<List<ColorType>> _colors$ = BehaviorSubject<List<ColorType>>();
  Sink<List<ColorType>> get inColorFilters => _colors$.sink;
  Stream<List<ColorType>> get outColorFilters => _colors$.stream;

  // Expose filter summary for other blocs to use
  Map<String, dynamic> get getFilters => _activeFilters;

  Map<String, dynamic> _activeFilters = {
    'price': null,
    'colors': List<ColorType>()
  };
  bool _price;
  List<ColorType> _colors;

  FilterBloc() {
    _colors = List<ColorType>();
    _price$.listen(_adjustPriceSelection);
    _colors$.listen(_adjustColorSelection);
  }

  // The two functions below serve the purpose of both updating our filters visually and keeping track of the
  // filter map that gets passed on to any product API calls
  void _adjustPriceSelection(bool selection) {
    _price = selection;
    _activeFilters['price'] = _price;
  }

  void _adjustColorSelection(List<ColorType> colors) {
    _colors = colors;
    _activeFilters['colors'] = _colors;
  }

  @override
  void dispose() {
    //TODO: Check for another way to dispose of these. If they are disposed here, then closing the drawer
    //once leads to an instant dispose and inability to reselect any filters after that.
    //_price$.close();
    //_colors$.close();
  }
}