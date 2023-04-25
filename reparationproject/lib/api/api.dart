import 'package:http/http.dart' as http;
import 'dart:convert';

class CallApi{
  final String url="http://127.0.0.1:8000/api/";
postData(data,apiUrl)async{
  var fullUrl=url+apiUrl;
  return await http.post(Uri.parse(fullUrl),
    body:jsonEncode(data),
    headers:setHeaders(),
  );
}


  setHeaders()=>{
  'content-type':'application/json',
    'Accept':'application/json',
  };
}