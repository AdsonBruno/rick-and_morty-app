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

  int _currentPage = 1;
  bool _hasMoreCharacters = true;
  bool _isLoadingMore = false;
  String? _currentSearchQuery;

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreCharacters => _hasMoreCharacters;
  String? get errorMessage => _errorMessage;

  Future<void> fetchInitialCharacters() async {
    _isLoading = true;
    _currentPage = 1;
    _hasMoreCharacters = true;
    _currentSearchQuery = null;
    _errorMessage = null;
    notifyListeners();

    try {
      final charactersList = await _repository.getCharacters(
        page: _currentPage,
      );
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
    if (name.isEmpty) return;

    _isLoading = true;
    _currentPage = 1;
    _hasMoreCharacters = true;
    _currentSearchQuery = name;
    _errorMessage = null;
    notifyListeners();

    try {
      final charactersList = await _repository.getCharacters(
        name: name,
        page: _currentPage,
      );
      _characters = charactersList;

      if (charactersList.length < 20) {
        _hasMoreCharacters = false;
      } else {
        _hasMoreCharacters = true;
      }
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

  Future<void> fetchMoreCharacters() async {
    if (_isLoadingMore || !_hasMoreCharacters) return;

    _isLoadingMore = true;
    notifyListeners();

    _currentPage++;
    try {
      final newCharacters = await _repository.getCharacters(
        name: _currentSearchQuery,
        page: _currentPage,
      );

      if (newCharacters.isEmpty) {
        _hasMoreCharacters = false;
      } else {
        _characters.addAll(newCharacters);
      }
    } on Exception catch (e) {
      _errorMessage = "Erro ao carregar mais: ${e.toString()}";
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}
