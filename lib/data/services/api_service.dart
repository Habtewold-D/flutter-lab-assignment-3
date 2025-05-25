import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/album.dart';
import '../models/photo.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String _albumsCacheKey = 'cached_albums';
  static const String _photosCacheKey = 'cached_photos';

  Future<List<Album>> getAlbums() async {
    try {
      // Try to get cached data first
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_albumsCacheKey);

      if (cachedData != null) {
        final List<dynamic> jsonList = json.decode(cachedData);
        return jsonList.map((json) => Album.fromJson(json)).toList();
      }

      // If no cache, fetch from API
      final response = await http.get(Uri.parse('$baseUrl/albums'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        // Cache the new data permanently
        await prefs.setString(_albumsCacheKey, response.body);
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
      // Try to get cached data first
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_photosCacheKey);

      if (cachedData != null) {
        final List<dynamic> jsonList = json.decode(cachedData);
        return jsonList.map((json) => Photo.fromJson(json)).toList();
      }

      // If no cache, fetch from API
      final response = await http.get(Uri.parse('$baseUrl/photos'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        // Cache the new data permanently
        await prefs.setString(_photosCacheKey, response.body);
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
      // For album-specific photos, we'll use a different cache key
      final cacheKey = '${_photosCacheKey}_$albumId';
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(cacheKey);

      if (cachedData != null) {
        final List<dynamic> jsonList = json.decode(cachedData);
        return jsonList.map((json) => Photo.fromJson(json)).toList();
      }

      // If no cache, fetch from API
      final response = await http.get(Uri.parse('$baseUrl/photos?albumId=$albumId'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        // Cache the new data permanently
        await prefs.setString(cacheKey, response.body);
        return jsonList.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos for album $albumId');
      }
    } catch (e) {
      throw Exception('Failed to load photos for album $albumId: $e');
    }
  }

  // Method to clear cache
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_albumsCacheKey);
    await prefs.remove(_photosCacheKey);
  }

  // Method to force refresh data from API
  Future<List<Album>> refreshAlbums() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$baseUrl/albums'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      await prefs.setString(_albumsCacheKey, response.body);
      return jsonList.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to refresh albums');
    }
  }

  // Method to force refresh photos from API
  Future<List<Photo>> refreshPhotos() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$baseUrl/photos'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      await prefs.setString(_photosCacheKey, response.body);
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to refresh photos');
    }
  }
} 