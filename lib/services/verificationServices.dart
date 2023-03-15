import 'package:http/http.dart' as http;
import 'dart:convert'as convert;
class VerificationServices {
final String baseurl = 'http://192.168.1.6:8000/api/verify';
    Verify(String? result) async{
    var response = await http.post( Uri.http(
      baseurl
    ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: convert.jsonEncode(<String, dynamic>{
        "qr_code": result,
      }),
    );
    var dataJson = convert.jsonDecode(response.body);
    if(response.statusCode == 200) {

      return  true;
    }else if(response.statusCode == 404){
      return false;
    }
  }

}