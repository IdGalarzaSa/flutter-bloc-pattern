import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:form_validation_bloc_pattern/src/models/product_model.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<List<ProductModel>> getProducts() async {
    final url = Uri.parse('$_baseUrl/products.json');
    final resp = await http.get(url);
    final List<ProductModel> productList = [];

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      final Map<String, dynamic> decodedData = json.decode(resp.body);
      if (decodedData != null) {
        decodedData.forEach((id, prod) {
          final tempProduct = new ProductModel.fromJson(prod);
          tempProduct.id = id;
          productList.add(tempProduct);
        });
      }
    }
    return productList;
  }

  Future<void> deleteProduct(ProductModel product) async {
    final url = Uri.parse('$_baseUrl/products/${product.id}.json');
    await http.delete(url);
  }

  Future<bool> editProduct(ProductModel product) async {
    final url = Uri.parse('$_baseUrl/products/${product.id}.json');
    final resp = await http.put(url, body: productoModelToJson(product));

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      print(resp.body);
      return true;
    } else {
      print(resp.body);
      return false;
    }
  }

  Future<String> _uploadImage(File image) async {
    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/ivangala/image/upload?upload_preset=r0ibrfku");
    final mimeType = mime(image.path).split('/'); //image/jpg
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);

    print(respData);

    return respData['secure_url'];
  }
}
