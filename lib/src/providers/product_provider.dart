import 'package:http/http.dart' as http;
import 'package:form_validation_bloc_pattern/src/models/product_model.dart';

class ProductProvider {
  final _baseUrl =
      "https://flutter-test-projects-3c9bd-default-rtdb.firebaseio.com";

  Future<bool> createProduct(ProductModel product) async {
    final url = Uri.parse('$_baseUrl/products.json');
    final resp = await http.post(url, body: productoModelToJson(product));

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      print(resp.body);
      return true;
    } else {
      print(resp.body);
      return false;
    }
  }
}
