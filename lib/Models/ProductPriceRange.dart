class ProductPriceRange {
  ProductPriceMinMax priceMin;
  ProductPriceMinMax priceMax;

  ProductPriceRange();

  ProductPriceRange.fromJson(Map<String, dynamic> map) {
    this.priceMin = ProductPriceMinMax.fromJson(map['min']);
    this.priceMax = ProductPriceMinMax.fromJson(map['max']);
  }
}

class ProductPriceMinMax {
  String currencyCode;
  num price;

  ProductPriceMinMax.fromJson(Map<String, dynamic> map) {
    this.currencyCode = map['currencyCode'] ?? '';
    this.price = map['withTax'] ?? 0;
  }
}