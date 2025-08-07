import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/theme/app_text_styles.dart';
import 'package:rick_and_morty_app/view_models/character_list_state.dart';
import 'package:rick_and_morty_app/view_models/character_list_view_model.dart';
import 'package:rick_and_morty_app/views/widgets/character_card.dart';

class CharacterListViewBody extends StatelessWidget {
  final ScrollController scrollController;

  const CharacterListViewBody({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterListViewModel>(
      builder: (context, viewModel, child) {
        final state = viewModel.state;

        if (state.status == ViewStatus.loading && state.characters.isEmpty) {
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

        if (state.status == ViewStatus.error && state.characters.isEmpty) {
          return Center(
            child: Text(
              'Ocorreu um erro: ${state.errorMessage}',
              style: AppTextStyles.errorMessage,
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state.characters.isEmpty) {
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
          itemCount: state.hasMoreCharacters
              ? state.characters.length + 1
              : state.characters.length,
          itemBuilder: (context, index) {
            if (index >= state.characters.length) {
              return state.status == ViewStatus.loadingMore
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
            final character = state.characters[index];

            return CharacterCard(character: character);
          },
        );
      },
    );
  }
}
