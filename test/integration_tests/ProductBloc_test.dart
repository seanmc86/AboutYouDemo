import 'package:AboutYouDemo/Blocs/ProductBloc.dart';
import 'package:AboutYouDemo/Models/Product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group("Bloc testing", () {
    test("Product Bloc testing", () async {
      ProductBloc productBloc = ProductBloc();
      productBloc.outProductList.listen(expectAsync1((value) {
        expect(value, isInstanceOf<List<Product>>());
      }));
    });
  });
}
