import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';
import 'package:rick_and_morty_app/core/theme/app_text_styles.dart';
import 'package:rick_and_morty_app/models/character_model.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Implementar navegação para tela de detalhes
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 13),

        color: AppColors.cardBackground,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 13,
                top: 21,
                right: 10,
                bottom: 21,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(34),
                child: Image.network(
                  character.image,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 140),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: AppTextStyles.characterName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Última localização conhecida',
                      style: AppTextStyles.cardLabel,
                    ),
                    Text(
                      character.lastLocationName,
                      style: AppTextStyles.cardValue,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text('Gênero:', style: AppTextStyles.cardLabel),
                    Text(character.species, style: AppTextStyles.cardValue),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
