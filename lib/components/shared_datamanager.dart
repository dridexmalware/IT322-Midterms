class SharedDataManager {
  static List<Map<String, dynamic>> productList = [];
  static void addProduct(Map<String, dynamic> productData) {
    productList.add(productData);
    notifyListeners();
  }

  static void notifyListeners() {}
}
