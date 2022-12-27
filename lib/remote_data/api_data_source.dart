import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class ApiDataSource {
  String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> fetchPosts() async {
    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
