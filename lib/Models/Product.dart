import 'dart:typed_data';
import 'package:AboutYouDemo/Models/ProductImage.dart';
import 'package:AboutYouDemo/Models/ProductAttributes.dart';
import 'package:AboutYouDemo/Models/ProductPriceRange.dart';

class Product {
  int id;
  bool isActive;
  bool isSoldOut;
  bool isNew;
  String createdAt;
  String updatedAt;
  List<ProductImage> images;
  ProductAttributes attributes;
  ProductPriceRange priceRange;
  Uint8List image;

  Product.fromJson(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.isActive = map['isActive'];
    this.isSoldOut = map['isSoldOut'];
    this.isNew = map['isNew'];
    this.createdAt = map['createdAt'];
    this.updatedAt = map['updatedAt'];

    List<dynamic> imagesList = map['images'] as List;
    this.images =
        imagesList.map((image) => ProductImage.fromJson(image)).toList();

    Map<String, dynamic> attributesMap = map['attributes'];
    this.attributes = ProductAttributes.fromJson(attributesMap);

    Map<String, dynamic> priceRangeMap = map['priceRange'];
    this.priceRange = ProductPriceRange.fromJson(priceRangeMap);
  }
}
