import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/models/character_model.dart';

enum ViewStatus { initial, loading, success, error, loadingMore }

@immutable
class CharacterListViewState {
  final ViewStatus status;
  final List<Character> characters;
  final String? errorMessage;
  final bool hasMoreCharacters;

  const CharacterListViewState({
    this.status = ViewStatus.initial,
    this.characters = const [],
    this.errorMessage,
    this.hasMoreCharacters = true,
  });

  CharacterListViewState copyWith({
    ViewStatus? status,
    List<Character>? characters,
    String? errorMessage,
    bool? hasMoreCharacters,
  }) {
    return CharacterListViewState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMoreCharacters: hasMoreCharacters ?? this.hasMoreCharacters,
    );
  }
}
