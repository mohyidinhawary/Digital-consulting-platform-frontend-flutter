import 'package:http/http.dart' as http;
import 'dart:convert';

class Crud {

  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url),);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;

      }
      else {
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print('ErrorCatch $e');
    }
  }

  postRequest(String url,Map data) async {
    try {
      var response = await http.post( Uri.parse(url),body:data);
      if (response.statusCode == 200) {
        print(data);
        print('success');
        print(response.body);
        var responseBody = jsonDecode(response.body);
        return responseBody;

      } else {
        print(data);
        print(response.body);
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print(data);
      print('ErrorCatch $e');
    }
  }
}
