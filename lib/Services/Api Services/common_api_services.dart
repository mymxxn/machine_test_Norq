import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machine_test/Utils/Constants/snackbar_services.dart';

class ApiManger {
  static final client = http.Client();
  static String baseurl = 'https://fakestoreapi.com/products';
  static Future fetchData() async {
    try {
      var responses = await client.get(
        Uri.parse('${baseurl}'),
      );
      if (responses.statusCode == 200) {
        var jsonResponse = jsonDecode(responses.body);
        print(jsonResponse);
        return jsonResponse;
      } else {
        throw Exception('Please check your connection settings');
      }
    } catch (e) {
      SnackBarServices.errorSnackBar(e.toString());
      return null;
    }
  }
}
