import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_portal/features/characters/domain/entities/character.dart';
import 'package:remote_portal/features/characters/presentation/providers/character_providers.dart';
import 'package:remote_portal/features/characters/presentation/providers/characters_state.dart';

class CharactersNotifier extends AsyncNotifier<CharactersState> {
  @override
  Future<CharactersState> build() async {
    final getCharacters = ref.watch(getCharactersProvider);
    final page = await getCharacters(page: 1);

    return CharactersState(
      characters: page.characters,
      currentPage: 1,
      hasMore: page.hasNext,
    );
  }

  Future<void> loadMore({bool retry = false}) async {
    final current = state.asData?.value;

    if (current == null) return;
    if (!current.hasMore || current.isLoadingMore) return;
    if (current.loadMoreError != null && !retry) return;

    state = AsyncData(
      current.copyWith(isLoadingMore: true, clearLoadMoreError: true),
    );

    try {
      final nextPage = current.currentPage + 1;
      final page = await ref.read(getCharactersProvider)(page: nextPage);

      state = AsyncData(
        current.copyWith(
          characters: [...current.characters, ...page.characters],
          currentPage: nextPage,
          hasMore: page.hasNext,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      state = AsyncData(
        current.copyWith(isLoadingMore: false, loadMoreError: e.toString()),
      );
    }
  }
}

final charactersProvider =
    AsyncNotifierProvider<CharactersNotifier, CharactersState>(
      CharactersNotifier.new,
    );

final characterDetailProvider = FutureProvider.autoDispose
    .family<Character, int>((ref, id) {
      return ref.watch(getCharacterDetailProvider)(id);
    });
