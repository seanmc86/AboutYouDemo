import 'dart:convert';
import 'package:AboutYouDemo/Helpers/Enums.dart';
import 'package:AboutYouDemo/Helpers/StringLocalizations.dart';
import 'package:AboutYouDemo/Models/Product.dart';
import 'package:http/http.dart';

abstract class ProductAPI {

  static String _formatColorList(List<ColorType> list) {
    String formattedString = '';
    for (var i = 0; i < list.length; i++) {
      if (i != 0)
        formattedString = formattedString + '%2C';
      formattedString = formattedString + StringLocalizations.filterColorCodeMap[list[i]];
    }
    return formattedString;
  }

  static String _baseURL = 'https://api-cloud.aboutyou.de/v1/products';

  static Future<List<Product>> fetchProducts({int page, int perPage, List<ColorType> colors, bool sortPrice}) async {
    page ??= 1;
    perPage ??= 10;
    colors ??= List<ColorType>();

    Map<String, String> _headers = {
      'Accept': 'application/json'
    };

    String _urlFilter = 
      '?with=attributes%2CpriceRange' +
      '&page=$page' +
      '&perPage=$perPage' +
      '&sortScore=category_scores' +
      '&sortChannel=etkp' +
      '&shopId=139';

    String _colorFilter = colors.isNotEmpty
      ? '&filters[color]=' + _formatColorList(colors)
      : '';
    String _priceFilter = sortPrice != null
      ? '&sort=price&sortDir=' + (sortPrice ? 'desc' : 'asc')
      : '';

    Response response = await get(
      _baseURL + _urlFilter + _colorFilter + _priceFilter,
      headers: _headers
    );

    List<Product> _productList = List<Product>();
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> body = json.decode(response.body);
      try {
        List<dynamic> entities = body['entities'];
        _productList = entities.map((product) => Product.fromJson(product)).toList();
      //TODO: Create more intelligent error handling per status codes & error type
      } catch (e) {
        print(e);
      }
    }

    return _productList;
  }
}