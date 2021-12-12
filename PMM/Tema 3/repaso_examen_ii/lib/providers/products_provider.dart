import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repaso_examen_ii/config/config.dart';

class ProductsProvider {
  static Uri uri =
      Uri.parse(/*'http://$ipCasa/restful/index.php/products_casa/products'*/'https://carlosprofe.synology.me/pedro_rest/index.php/products_casa/products');
  static String endpointProduct =
      'https://carlosprofe.synology.me/pedro_rest/index.php/products_casa/product/';
  static String endpointProductByName =
      'https://carlosprofe.synology.me/pedro_rest/index.php/products_casa/productByName/';
  static String endpointProductsByRange =
      'https://carlosprofe.synology.me/pedro_rest/index.php/products_casa/productsByRange/';
  static Future<List<dynamic>> getAll() async {
    Map<String, dynamic> res =
        await http.get(uri).then((value) => jsonDecode(value.body));

    return res['prods'];
  }

  static Future<Map<String, dynamic>> getProduct(String id) async {
    Uri url = Uri.parse('$endpointProduct$id');
    return await http.get(url).then((value) => jsonDecode(value.body));
  }

  static Future<List<dynamic>> getUserProducts(int user) async {
    List<dynamic> res = await getAll();

    return res.where((element) => int.parse(element['user']) == user).toList();
  }

  static Future<dynamic> searchProductsByName(String name) async {
    Uri url = Uri.parse('$endpointProductByName$name');
    return await http.get(url).then((value) => jsonDecode(value.body));
  }

  static Future<List<dynamic>> productsByRange(int init, int range) async =>
      await http
          .get(Uri.parse('$endpointProductsByRange$init/$range'))
          .then((value) => jsonDecode(value.body));
}

void main(List<String> args) async {
  // List<dynamic> lista = await ProductsProvider.getAll();

  // lista.forEach((element) {
  //   print(element as Map);
  // });
  print(await ProductsProvider.getUserProducts(1));
}
