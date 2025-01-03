import 'dart:convert';
import 'package:http/http.dart' as http;
import 'unsplash_api_key.dart';

class ImageSearchRepository {
  Future<List<String>> searchImages(String query) async {
    try {
      final String url =
          'https://api.unsplash.com/search/photos?query=$query&per_page=10&client_id=${UnsplashApiKey.unsplashClientID}';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final results = jsonData['results'] as List;
        print(results);
        return results
            .map<String>((result) => result['urls']['regular'] as String)
            .toList();
      } else {
        throw Exception('Failed to fetch images: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
