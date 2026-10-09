import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_portal/features/characters/presentation/providers/characters_notifier.dart';
import 'package:remote_portal/features/characters/presentation/widgets/character_grid.dart';
import 'package:remote_portal/features/characters/presentation/widgets/empty_view.dart';

import '../widgets/error_view.dart';

class CharactersScreen extends ConsumerStatefulWidget {
  const CharactersScreen({super.key});

  @override
  ConsumerState<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends ConsumerState<CharactersScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(charactersProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String value) {
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _applySearch(value);
    });
  }

  void _applySearch(String value) {
    _debounce?.cancel();
    ref.read(searchQueryProvider.notifier).state = value.trim();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {});
    _applySearch('');
  }

  @override
  Widget build(BuildContext context) {
    final charactersAsync = ref.watch(charactersProvider);
    final query = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Buscar personaje...',
              leading: const Icon(Icons.search),
              trailing: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _clearSearch,
                  ),
              ],
              textInputAction: TextInputAction.search,
              onChanged: _onSearchChanged,
              onSubmitted: _applySearch,
            ),
          ),
          Expanded(
            child: charactersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ErrorView(
                message: error.toString(),
                onRetry: () => ref.invalidate(charactersProvider),
              ),
              data: (state) {
                if (state.characters.isEmpty) {
                  return EmptyView(query: query);
                }
                return RefreshIndicator(
                  onRefresh: () => ref.refresh(charactersProvider.future),
                  child: CharacterGrid(
                    state: state,
                    controller: _scrollController,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
