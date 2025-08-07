import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/repositories/abstract/character_repository.dart';
import 'package:rick_and_morty_app/view_models/character_list_state.dart';

class CharacterListViewModel extends ChangeNotifier {
  final CharacterRepository _repository;

  CharacterListViewModel({required CharacterRepository repository})
    : _repository = repository;

  CharacterListViewState _state = const CharacterListViewState();
  CharacterListViewState get state => _state;

  int _currentPage = 1;
  String? _currentSearchQuery;

  Future<void> fetchInitialCharacters() async {
    _currentPage = 1;
    _currentSearchQuery = null;
    _state = _state.copyWith(status: ViewStatus.loading);
    notifyListeners();

    try {
      final charactersList = await _repository.getCharacters(
        page: _currentPage,
      );

      _state = _state.copyWith(
        status: ViewStatus.success,
        characters: charactersList,
        hasMoreCharacters: charactersList.isNotEmpty,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        status: ViewStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }

    notifyListeners();
  }

  Future<void> searchCharacters(String name) async {
    if (name.isEmpty) {
      clearSearch();
      return;
    }

    _currentPage = 1;
    _currentSearchQuery = name;
    _state = _state.copyWith(status: ViewStatus.loading);
    notifyListeners();

    try {
      final charactersList = await _repository.getCharacters(
        name: name,
        page: _currentPage,
      );
      _state = _state.copyWith(
        status: ViewStatus.success,
        characters: charactersList,
        hasMoreCharacters: charactersList.length >= 20,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        status: ViewStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
        characters: [],
      );
    }
    notifyListeners();
  }

  void clearSearch() {
    fetchInitialCharacters();
  }

  Future<void> fetchMoreCharacters() async {
    if (_state.status == ViewStatus.loadingMore || !_state.hasMoreCharacters) return;

    _state = _state.copyWith(status: ViewStatus.loadingMore);
    notifyListeners();

    _currentPage++;
    try {
      final newCharacters = await _repository.getCharacters(
        name: _currentSearchQuery,
        page: _currentPage,
      );

      _state = _state.copyWith(
        status: ViewStatus.success,
        characters: [..._state.characters, ...newCharacters],
        hasMoreCharacters: newCharacters.isNotEmpty,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        status: ViewStatus.error,
        errorMessage: 'Erro ao carregar mais: ${e.toString()}',
      );
    }
    notifyListeners();
  }
}
