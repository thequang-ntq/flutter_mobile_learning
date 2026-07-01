import 'dart:convert';

import 'package:code/models/album.dart';
import 'package:http/http.dart' as http;

Future<Album> httpFetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: {'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}
