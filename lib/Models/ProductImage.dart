class ProductImage {
  String hash;
  Map<String, dynamic> attributes;

  ProductImage.fromJson(Map<String, dynamic> map) {
    this.hash = map['hash'];
    this.attributes = map['attributes'];
  }
}