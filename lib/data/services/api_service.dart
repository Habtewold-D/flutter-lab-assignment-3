import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Album>> getAlbums() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/albums'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Album.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }

  Future<List<Photo>> getPhotos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/photos'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }

  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/photos?albumId=$albumId'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos for album $albumId');
      }
    } catch (e) {
      throw Exception('Failed to load photos for album $albumId: $e');
    }
  }
} 