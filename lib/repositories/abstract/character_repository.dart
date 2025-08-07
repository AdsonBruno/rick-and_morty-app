import '../../models/character_model.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters({String? name, int page = 1});
}
