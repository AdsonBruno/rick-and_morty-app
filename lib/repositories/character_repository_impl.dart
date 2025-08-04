import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/repositories/abstract/character_repository.dart';
import 'package:rick_and_morty_app/models/character_model.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final Dio _dio;

  CharacterRepositoryImpl({Dio? dio}) : _dio = dio ?? Dio();

  static const String _baseUrl = 'https://rickandmortyapi.com/api';

  @override
  Future<List<Character>> getCharacters({String? name}) async {
    try {
      String url = '$_baseUrl/character';

      if (name != null && name.isNotEmpty) {
        url += '/?name=$name';
      }

      // final response = await _dio.get('$_baseUrl/character');
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];

        return results.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }

      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
