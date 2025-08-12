import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/repositories/abstract/character_repository.dart';
import 'package:rick_and_morty_app/view_models/character_list_state.dart';
import 'package:rick_and_morty_app/view_models/character_list_view_model.dart';

import 'character_list_view_model_test.mocks.dart';

@GenerateMocks([CharacterRepository])
void main() {
  late CharacterListViewModel viewModel;
  late MockCharacterRepository mockRepository;

  setUp(() {
    mockRepository = MockCharacterRepository();
    viewModel = CharacterListViewModel(repository: mockRepository);
  });

  Character createTestCharacter({required int id, required String name}) =>
      Character(
        id: id,
        name: name,
        status: 'Alive',
        species: 'Human',
        gender: 'Male',
        image: 'url-image',
        lastLocationName: 'Earth',
      );

  group('fetchInitialCharacters', () {
    test(
      'should update the state for success with a list of characters',
      () async {
        final characterList = [createTestCharacter(id: 1, name: 'Rick')];
        when(
          mockRepository.getCharacters(page: 1),
        ).thenAnswer((_) async => characterList);

        await viewModel.fetchInitialCharacters();

        expect(viewModel.state.status, ViewStatus.success);
        expect(viewModel.state.characters, isNotEmpty);
        expect(viewModel.state.characters.first.name, 'Rick');
        expect(viewModel.state.errorMessage, isNull);
      },
    );

    test(
      'should update the state for error when the repository fails',
      () async {
        when(
          mockRepository.getCharacters(page: 1),
        ).thenThrow(Exception('Falha na API'));

        await viewModel.fetchInitialCharacters();

        expect(viewModel.state.status, ViewStatus.error);
        expect(viewModel.state.characters, isEmpty);
        expect(viewModel.state.errorMessage, 'Falha na API');
      },
    );
  });

  group('fetchMoreCharacters', () {
    test('should add new characters to the existing list', () async {
      final initialList = [createTestCharacter(id: 1, name: 'Rick')];
      when(
        mockRepository.getCharacters(page: 1),
      ).thenAnswer((_) async => initialList);
      await viewModel.fetchInitialCharacters();

      final moreCharacters = [createTestCharacter(id: 2, name: 'Morty')];
      when(
        mockRepository.getCharacters(page: 2),
      ).thenAnswer((_) async => moreCharacters);

      await viewModel.fetchMoreCharacters();

      expect(viewModel.state.status, ViewStatus.success);
      expect(viewModel.state.characters.length, 2);
      expect(viewModel.state.characters.last.name, 'Morty');
      expect(viewModel.state.hasMoreCharacters, isTrue);
    });

    test(
      'should define hasmorecharacters as false when the API returns an empty list',
      () async {
        final initialList = [createTestCharacter(id: 1, name: 'Rick')];
        when(
          mockRepository.getCharacters(page: 1),
        ).thenAnswer((_) async => initialList);
        await viewModel.fetchInitialCharacters();

        when(mockRepository.getCharacters(page: 2)).thenAnswer((_) async => []);

        await viewModel.fetchMoreCharacters();

        expect(viewModel.state.status, ViewStatus.success);
        expect(viewModel.state.characters.length, 1);
        expect(viewModel.state.hasMoreCharacters, isFalse);
      },
    );
  });
}
