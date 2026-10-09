import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_portal/features/characters/presentation/providers/characters_notifier.dart';
import 'package:remote_portal/features/characters/presentation/widgets/character_grid.dart';

import '../widgets/error_view.dart';

class CharactersScreen extends ConsumerStatefulWidget {
  const CharactersScreen({super.key});

  @override
  ConsumerState<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends ConsumerState<CharactersScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(charactersProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final charactersAsync = ref.watch(charactersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: charactersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(charactersProvider),
        ),
        data: (state) => RefreshIndicator(
          onRefresh: () => ref.refresh(charactersProvider.future),
          child: CharacterGrid(state: state, controller: _scrollController),
        ),
      ),
    );
  }
}
