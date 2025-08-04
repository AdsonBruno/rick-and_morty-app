import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/repositories/character_repository_impl.dart';
import 'package:rick_and_morty_app/view_models/character_list_view_model.dart';
import 'package:rick_and_morty_app/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          CharacterListViewModel(repository: CharacterRepositoryImpl())
            ..fetchCharacters(),
      child: MaterialApp(
        title: 'Rick And Morty App',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF272B33),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF272B33)),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
