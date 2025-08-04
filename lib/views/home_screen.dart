import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/theme/app_text_styles.dart';
import 'package:rick_and_morty_app/view_models/character_list_view_model.dart';
import 'package:rick_and_morty_app/views/widgets/character_card.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<CharacterListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.characters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null && viewModel.characters.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Ocorreu um erro: ${viewModel.errorMessage}',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.errorMessage,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: viewModel.characters.length,
            itemBuilder: (context, index) {
              final character = viewModel.characters[index];
              return CharacterCard(character: character);
            },
          );
        },
      ),
    );
  }
}
