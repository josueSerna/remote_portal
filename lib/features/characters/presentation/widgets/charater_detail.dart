import 'package:flutter/material.dart';
import 'package:remote_portal/features/characters/domain/entities/character.dart';
import 'package:remote_portal/features/characters/presentation/widgets/info_tile.dart';
import 'package:remote_portal/features/characters/presentation/widgets/status_badge.dart';

class CharacterDetail extends StatelessWidget {
  const CharacterDetail({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final created = character.created.toLocal();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: Hero(
            tag: 'character-image-${character.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                character.image,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(
                  width: 250,
                  height: 250,
                  child: Icon(Icons.broken_image_outlined, size: 64),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(child: Text(character.name, style: textTheme.headlineSmall)),
        const SizedBox(height: 8),
        Center(child: StatusBadge(status: character.status)),
        const SizedBox(height: 24),
        InfoTile(
          icon: Icons.category_outlined,
          label: 'Especie',
          value: character.species,
        ),
        if (character.type.isNotEmpty)
          InfoTile(
            icon: Icons.label_outline,
            label: 'Tipo',
            value: character.type,
          ),
        InfoTile(
          icon: Icons.person_outline,
          label: 'Género',
          value: character.gender,
        ),
        InfoTile(
          icon: Icons.public,
          label: 'Origen',
          value: character.originName,
        ),
        InfoTile(
          icon: Icons.place_outlined,
          label: 'Última ubicación',
          value: character.locationName,
        ),
        InfoTile(
          icon: Icons.tv,
          label: 'Episodios',
          value: '${character.episodeCount}',
        ),
        InfoTile(
          icon: Icons.calendar_today_outlined,
          label: 'Creado en la API',
          value: '${created.day}/${created.month}/${created.year}',
        ),
      ],
    );
  }
}
