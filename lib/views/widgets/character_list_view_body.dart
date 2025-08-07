import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/theme/app_text_styles.dart';
import 'package:rick_and_morty_app/view_models/character_list_view_model.dart';
import 'package:rick_and_morty_app/views/widgets/character_card.dart';

class CharacterListViewBody extends StatelessWidget {
  final ScrollController scrollController;

  const CharacterListViewBody({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterListViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading && viewModel.characters.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/gifs/rick-and-morty-television.gif',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          );
        }

        if (viewModel.errorMessage != null && viewModel.characters.isEmpty) {
          return Center(
            child: Text(
              'Ocorreu um erro: ${viewModel.errorMessage}',
              style: AppTextStyles.errorMessage,
              textAlign: TextAlign.center,
            ),
          );
        }

        if (viewModel.characters.isEmpty) {
          return Center(
            child: Text(
              'Nenhum personagem encontrado',
              style: AppTextStyles.messageInformation,
            ),
          );
        }

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(8.0),
          itemCount: viewModel.hasMoreCharacters
              ? viewModel.characters.length + 1
              : viewModel.characters.length,
          itemBuilder: (context, index) {
            if (index >= viewModel.characters.length) {
              return viewModel.isLoadingMore
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/gifs/rick-and-morty-television.gif',
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }
            final character = viewModel.characters[index];

            return CharacterCard(character: character);
          },
        );
      },
    );
  }
}
