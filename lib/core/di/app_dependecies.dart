import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rick_and_morty_app/repositories/abstract/character_repository.dart';
import 'package:rick_and_morty_app/repositories/character_repository_impl.dart';
import 'package:rick_and_morty_app/view_models/character_list_view_model.dart';

List<SingleChildWidget> get appProviders => [
  Provider<CharacterRepository>(create: (_) => CharacterRepositoryImpl()),

  ChangeNotifierProvider(
    create: (context) =>
        CharacterListViewModel(repository: context.read<CharacterRepository>()),
  ),
];
