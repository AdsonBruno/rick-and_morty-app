import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/repositories/abstract/character_repository.dart';

class CharacterListViewModel extends ChangeNotifier {
  final CharacterRepository _repository;

  CharacterListViewModel({required CharacterRepository repository})
    : _repository = repository;

  List<Character> _characters = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCharacters() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _characters = await _repository.getCharacters();
    } on Exception catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
