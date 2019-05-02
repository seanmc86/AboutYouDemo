class ProductAttributes {
  ProductBrand brand;
  ProductName name;

  ProductAttributes();

  //TODO: Add remaining attribute maps to flesh out ProductAttributes more
  ProductAttributes.fromJson(Map<String, dynamic> map) {
    this.brand = ProductBrand.fromJson(map['brand']);
    this.name = ProductName.fromJson(map['name']);
  }
}

class ProductBrand {
  String label;

  //TODO: Base structure for an attribute map, can add in more fields to give more detail
  ProductBrand.fromJson(Map<String, dynamic> map) {
    this.label = map['values']['label'] ?? '';
  }
}

class ProductName {
  String label;

  //TODO: Base structure for an attribute map, can add in more fields to give more detail
  ProductName.fromJson(Map<String, dynamic> map) {
    this.label = map['values']['label'] ?? '';
  }
}