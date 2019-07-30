import 'dart:convert';
import 'package:AboutYouDemo/Helpers/Enums.dart';
import 'package:AboutYouDemo/Helpers/StringLocalizations.dart';
import 'package:AboutYouDemo/Models/Product.dart';
import 'package:AboutYouDemo/Models/State.dart';
import 'package:http/http.dart';

class ProductAPI {
  final String _baseURL = 'https://api-cloud.aboutyou.de/v1/products';
  final Map<String, String> _headers = {'Accept': 'application/json'};
  final Client client;

  ProductAPI(this.client);

  static String _formatColorList(List<ColorType> list) {
    String formattedString = '';
    for (var i = 0; i < list.length; i++) {
      if (i != 0)
        formattedString = formattedString + '%2C';
      formattedString = formattedString + StringLocalizations.filterColorCodeMap[list[i]];
    }
    return formattedString;
  }

  Future<State> fetchProducts(
      {int page, int perPage, List<ColorType> colors, bool sortPrice}) async {
    page ??= 1;
    perPage ??= 10;
    colors ??= List<ColorType>();

    String _urlFilter = '?with=attributes%2CpriceRange' +
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

    Response response = await client.get(
        _baseURL + _urlFilter + _colorFilter + _priceFilter,
        headers: _headers);

    int time = DateTime.now().millisecondsSinceEpoch;
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> body = json.decode(response.body);
      try {
        List<dynamic> entities = body['entities'];
        List<Product> _productList =
            entities.map((product) => Product.fromJson(product)).toList();
        print('Time calc: ${DateTime.now().millisecondsSinceEpoch - time}');

        return State<List<Product>>.success(_productList);
      } catch (e) {
        print(e);
        return State<String>.error('Could not parse products.');
      }
    } else {
      return State<String>.error('Could not retrieve products.');
    }
  }

  List<Product> parseData(String body) {
    Map<dynamic, dynamic> parsed = json.decode(body);
    List<dynamic> entities = parsed['entities'];

    return entities.map((product) => Product.fromJson(product)).toList();
  }
}
