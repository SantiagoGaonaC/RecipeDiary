import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'shared_preferences.dart';

class Post {
  final String postId;
  final String userId;
  final String title;
  final String content;
  final DateTime createdAt;

  const Post(
      {required this.postId,
      required this.userId,
      required this.title,
      required this.content,
      required this.createdAt});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['_id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

Future<List<Post>> fetchMyPosts() async {
  print("---------------------FETCHING POSTS------------------");
  String? token = await MySharedPreferences.getToken();
  if (token == null) {
    throw Exception('Token is null');
  }
  final url = Uri.parse(
      'http://recipediary.bucaramanga.upb.edu.co:4000/api/socmed/my-posts');
  final headers = {'Authorization': 'Bearer ${token}'};

  try {
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print('Success');
      return compute(parsePosts, response.body);
    } else {
      print('Failed to fetch: not code 200');
      throw Exception('Failed to fetch posts');
    }
  } catch (e) {
    print("Failed to fetch");
    throw Exception('Failed to fetch posts: $e');
  }
}

//Convertir response a una Lista<Post>.

List<Post> parsePosts(String responseBody) {
  print("---------------------PARSING POSTS------------------");
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  final parsedWithoutV = parsed.map((map) => map..remove('__v')).toList();
  print(parsedWithoutV);
  print(parsedWithoutV.runtimeType);

  try {
    List<Post> lista =
        parsedWithoutV.map<Post>((json) => Post.fromJson(json)).toList();
    return lista;
  } catch (e) {
    print("Failed to parse posts: $e");
    return [];
  }
}
