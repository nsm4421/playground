class ProductInfo {
  final String productCode;
  final String productName;
  final String productCategory;

  ProductInfo({
    required this.productCode,
    required this.productName,
    required this.productCategory,
  });
}

final dummyProduct = ProductInfo(
  productCode: '6XXXX',
  productName: '[TEST]무배당 내Mom같은 어린이보험',
  productCategory: '상해보험',
);
