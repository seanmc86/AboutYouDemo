import 'dart:async';
import 'package:AboutYouDemo/Blocs/BlocProvider.dart';
import 'package:AboutYouDemo/Models/Product.dart';
import 'package:AboutYouDemo/Services/ProductAPI.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProductBloc implements BlocBase {
  // Product list interfaces
  BehaviorSubject<List<Product>> _productList$ =
      BehaviorSubject<List<Product>>();
  Sink<List<Product>> get inProductList => _productList$.sink;
  Stream<List<Product>> get outProductList => _productList$.stream;

  // Active Filter interfaces
  BehaviorSubject<Map<String, dynamic>> _active$ =
      BehaviorSubject<Map<String, dynamic>>();
  Sink<Map<String, dynamic>> get inActiveFilters => _active$.sink;
  Stream<Map<String, dynamic>> get outActiveFilters => _active$.stream;

  List<Product> _productList = List<Product>();
  int _currentPage = 1;
  bool loading = false;
  bool reachedEnd = false;
  Map<String, dynamic> _activeFilters = {};

  ProductBloc() {
    updateProductList();
    _active$.listen(_adjustFilters);
  }

  // Pulls products from API and then increments page number for next call, if needed
  void updateProductList() async {
    if (loading || reachedEnd) return;
    loading = true;

    await ProductAPI.fetchProducts(
            page: _currentPage,
            perPage: 10,
            colors: _activeFilters['colors'],
            sortPrice: _activeFilters['price'])
        .then((newProductList) {
      _currentPage += 1;
      loading = false;
      if (newProductList.isEmpty || newProductList.length < 10) {
        reachedEnd = true;
        return;
      }

      if (!_productList.contains(newProductList.first))
        _productList.addAll(newProductList);

      inProductList.add(_productList);
    }).catchError((error) {
      print(ProductAPI.errorMap);
      loading = false;
    });
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
    inProductList.add(List<
        Product>()); // This ensures the screen is cleared before a new filtered list comes in
    await updateProductList();
  }

  @override
  void dispose() {
    _productList$.close();
  }
}
