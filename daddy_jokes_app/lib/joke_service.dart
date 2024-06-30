import 'dart:convert';
import 'package:http/http.dart' as http;

class JokeService {
  static const String _apiUrl =
      'https://official-joke-api.appspot.com/random_joke';

  Future<Map<String, String>> getJoke() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {'setup': data['setup'], 'punchline': data['punchline']};
    } else {
      throw Exception('Failed to load joke');
    }
  }
}
