class ProductAttributes {
  ProductBrand brand;

  ProductAttributes();

  //TODO: Add remaining attribute maps to flesh out ProductAttributes more
  ProductAttributes.fromJson(Map<String, dynamic> map) {
    this.brand = ProductBrand.fromJson(map['brand']);
  }
}

class ProductBrand {
  String label;

  //TODO: Base structure for an attribute map, can add in more fields to give more detail
  ProductBrand.fromJson(Map<String, dynamic> map) {
    this.label = map['values']['label'] ?? '';
  }
}