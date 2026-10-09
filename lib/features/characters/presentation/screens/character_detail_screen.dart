import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_portal/features/characters/presentation/providers/characters_notifier.dart';
import 'package:remote_portal/features/characters/presentation/widgets/charater_detail.dart';

import '../widgets/error_view.dart';

class CharacterDetailScreen extends ConsumerWidget {
  const CharacterDetailScreen({super.key, required this.characterId});

  final int? characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = characterId;

    if (id == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const ErrorView(
          message: 'El identificador del personaje no es válido.',
        ),
      );
    }

    final characterAsync = ref.watch(characterDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Text(characterAsync.asData?.value.name ?? 'Detalle'),
      ),
      body: characterAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(characterDetailProvider(id)),
        ),
        data: (character) => CharacterDetail(character: character),
      ),
    );
  }
}
