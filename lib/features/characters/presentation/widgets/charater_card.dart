import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remote_portal/features/characters/domain/entities/character.dart';
import 'package:remote_portal/features/characters/presentation/widgets/status_badge.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => context.pushNamed(
          'character-detail',
          pathParameters: {'id': character.id.toString()},
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: 'character-image-${character.id}',
                child: Image.network(
                  character.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.broken_image_outlined, size: 40),
                  ),
                ),
              ),
            ),
            // El texto ocupa solo lo que necesita (mainAxisSize.min).
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  StatusBadge(status: character.status),
                  const SizedBox(height: 4),
                  Text(
                    character.species,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
