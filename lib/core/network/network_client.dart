import 'package:http/http.dart' as http;

class NetworkClient {
  final String baseUrl = "https://reqres.in/api/users";

  Future<http.Response> get() async {
    return await http.get(Uri.parse(baseUrl));
  }
}