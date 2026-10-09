import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_portal/features/characters/presentation/providers/characters_notifier.dart';
import 'package:remote_portal/features/characters/presentation/providers/characters_state.dart';
import 'package:remote_portal/features/characters/presentation/widgets/charater_card.dart';

class CharacterGrid extends ConsumerWidget {
  const CharacterGrid({
    super.key,
    required this.state,
    required this.controller,
  });

  final CharactersState state;
  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showFooter = state.hasMore || state.loadMoreError != null;
    final itemCount = state.characters.length + (showFooter ? 1 : 0);

    return GridView.builder(
      controller: controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index < state.characters.length) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: CharacterCard(character: state.characters[index]),
          );
        }

        if (state.loadMoreError != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Text(state.loadMoreError!, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => ref
                      .read(charactersProvider.notifier)
                      .loadMore(retry: true),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
