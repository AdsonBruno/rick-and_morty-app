import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rick_and_morty_app/models/character_model.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';
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

  test('should seek characters and fill the list when successful', () async {
    final characterList = [
      Character(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        image: 'https://url.image',
        lastLocationName: 'Citadel of Ricks',
      ),
    ];
    when(mockRepository.getCharacters()).thenAnswer((_) async => characterList);

    await viewModel.fetchCharacters();

    expect(viewModel.characters, isNotEmpty);
    expect(viewModel.characters.length, 1);
    expect(viewModel.characters.first.name, 'Rick Sanchez');
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.errorMessage, isNull);
  });
}
