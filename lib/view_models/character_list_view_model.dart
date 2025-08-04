import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/repositories/abstract/character_repository.dart';

class CharacterListViewModel extends ChangeNotifier {
  final CharacterRepository _repository;

  CharacterListViewModel({required CharacterRepository repository})
    : _repository = repository;

  List<Character> _characters = [];
  List<Character> _originalCharactersList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchInitialCharacters() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final charactersList = await _repository.getCharacters();
      _characters = charactersList;
      _originalCharactersList = charactersList;
    } on Exception catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchCharacters(String name) async {
    if (name.isEmpty) {
      _characters = _originalCharactersList;
      _errorMessage = null;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _characters = await _repository.getCharacters(name: name);
    } on Exception catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _characters = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _characters = _originalCharactersList;
    _errorMessage = null;
    notifyListeners();
  }
}
