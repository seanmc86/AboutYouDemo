import 'dart:async';
import 'package:AboutYouDemo/Blocs/BlocProvider.dart';
import 'package:AboutYouDemo/Models/Product.dart';
import 'package:AboutYouDemo/Models/State.dart';
import 'package:AboutYouDemo/Services/ProductAPI.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProductBloc implements BlocBase {

  // Product list interfaces
  BehaviorSubject<List<Product>> _productList$ = BehaviorSubject<List<Product>>();
  Sink<List<Product>> get inProductList => _productList$.sink;
  Stream<List<Product>> get outProductList => _productList$.stream;

  // Active Filter interfaces
  BehaviorSubject<Map<String, dynamic>> _active$ = BehaviorSubject<Map<String, dynamic>>();
  Sink<Map<String, dynamic>> get inActiveFilters => _active$.sink;
  Stream<Map<String, dynamic>> get outActiveFilters => _active$.stream;
  
  List<Product> _productList = List<Product>();
  int _currentPage = 1;
  Map<String, dynamic> _activeFilters = {};
  ProductAPI productAPI;

  ProductBloc() {
    productAPI = ProductAPI(Client());
    updateProductList();
    _active$.listen(_adjustFilters);
  }

  // Pulls products from API and then increments page number for next call, if needed
  void updateProductList() async {
    List<Product> newProductList = await ProductAPI.fetchProducts(
      page: _currentPage,
      perPage: 10,
      colors: _activeFilters['colors'],
      sortPrice: _activeFilters['price']
    );

    State state = await productAPI.fetchProducts(
            page: _currentPage,
            perPage: 10,
            colors: _activeFilters['colors'],
            sortPrice: _activeFilters['price']);

    loading = false;
    if (state is SuccessState) {
      _currentPage += 1;
      if (state.value.isEmpty || state.value.length < 10) {
        reachedEnd = true;
      }

      if (!_productList.contains(state.value.first))
        _productList.addAll(state.value);
      inProductList.add(state.value);

    } else if (state is ErrorState) {
      _productList$.addError(state.msg);
    }
  }

  // When new filters are received from the filter stream, reset our product list
  void _adjustFilters(Map<String, dynamic> filterMap) {
    _activeFilters = filterMap;
    resetState();
  }

  // Clears existing products and pulls a new batch
  Future<void> resetState() async {
    _productList.clear();
    _currentPage = 1;
    await updateProductList();
  }

  @override
  void dispose() {
    _productList$.close();
  }
}