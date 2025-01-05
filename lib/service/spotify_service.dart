import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SpotifyService {
  final String clientId = '06ec7b9861ce41e281f6ca197af075a7';
  final String clientSecret = 'a1b29d2f259240f9826cf3c568bb56f7';
  String? _accessToken;

  Future<void> _getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
            'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret')),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data['access_token'];
    } else {
      throw Exception('Failed to load access token');
    }
  }

  Future<List<Map<String, String>>> searchTracks(String query) async {
    if (_accessToken == null) {
      await _getAccessToken();
    }

    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/search?q=$query&type=track&limit=5'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final tracks = data['tracks']['items'] as List;

      return tracks.map<Map<String, String>>((track) {
        return {
          'name': track['name'] as String,
          'artist': track['artists'][0]['name'] as String,
          'albumArt': track['album']['images'][0]['url'] as String,
        };
      }).toList();
    } else {
      throw Exception('Failed to load tracks');
    }
  }
}
