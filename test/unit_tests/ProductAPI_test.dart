import 'package:AboutYouDemo/Helpers/Enums.dart';
import 'package:AboutYouDemo/Models/Product.dart';
import 'package:AboutYouDemo/Models/State.dart';
import 'package:AboutYouDemo/Services/ProductAPI.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:AboutYouDemo/Blocs/ProductBloc.dart';
import 'package:http/http.dart' as http;
import 'mock_client.dart';
import 'sample_response.dart';

class MockProductBloc extends Mock implements ProductBloc {}

class MockProductAPI extends Mock implements ProductAPI {}

main() {
  final mockClient = MockClient();
  ProductAPI productAPI = ProductAPI(mockClient);
  Map<String, String> _headers = {'Accept': 'application/json'};
  group('API testing', () {
    test('get products success case', () async {
      String _url = 'https://api-cloud.aboutyou.de/v1/products' +
          '?with=attributes%2CpriceRange' +
          '&page=1' +
          '&perPage=10' +
          '&sortScore=category_scores' +
          '&sortChannel=etkp' +
          '&shopId=139';
      when(mockClient.get(_url, headers: _headers)).thenAnswer(
          (_) async => http.Response(
                  SampleResponse.productResponse, 200));
      expect(
          await productAPI.fetchProducts(
              page: 1,
              perPage: 10,
              colors: List<ColorType>(),
              sortPrice: null),
          isInstanceOf<SuccessState<List<Product>>>());
    });

    test('get products error (status code) case', () async {
      String _url = 'https://api-cloud.aboutyou.de/v1/products' +
          '?with=attributes%2CpriceRange' +
          '&page=1000' +
          '&perPage=1000' +
          '&sortScore=category_scores' +
          '&sortChannel=etkp' +
          '&shopId=139';
      when(mockClient.get(_url, headers: _headers)).thenAnswer((_) async =>
          http.Response(SampleResponse.internalErrorResponse, 500));
      expect(
          await productAPI.fetchProducts(
              page: 1000,
              perPage: 1000,
              colors: List<ColorType>(),
              sortPrice: null),
          isInstanceOf<ErrorState<String>>());
    });

    test('get products error (data parsing) case', () async {
      String _url = 'https://api-cloud.aboutyou.de/v1/products' +
          '?with=attributes%2CpriceRange' +
          '&page=1' +
          '&perPage=10' +
          '&sortScore=category_scores' +
          '&sortChannel=etkp' +
          '&shopId=139';
      when(mockClient.get(_url, headers: _headers)).thenAnswer((_) async =>
          http.Response(SampleResponse.badlyFormattedResponse, 200));
      expect(
          await productAPI.fetchProducts(
              page: 1,
              perPage: 10,
              colors: List<ColorType>(),
              sortPrice: null),
          isInstanceOf<ErrorState<String>>());
    });
  });
}
