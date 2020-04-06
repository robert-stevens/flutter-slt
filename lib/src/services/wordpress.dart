import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:shareLearnTeach/src/models/user.dart';

class DataSource<T> {

  DataSource({this.url,this.parse});

  final String url; 
  T Function(Response response) parse;
}

class Webservice {

  Future<T> load<T>(DataSource<T> resource, String params) async {

      final String token = await User.getToken();
      // print('token: $token');
      final http.Response response = await http.get(resource.url+params, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if(response.statusCode == 200) {
        return resource.parse(response);
      } else {
        print('error code: ${response.statusCode}');
        print('error error: $response');
        throw Exception('Failed to load data!');
      }
  }

}