import 'package:flutter/material.dart';
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

        color: const Color(0xFF3C3E44),
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFFFF9800),
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Última localização conhecida:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      character.lastLocationName,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gênero:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      character
                          .species, // O protótipo mostra a espécie como Gênero
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
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
