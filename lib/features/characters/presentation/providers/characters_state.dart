import 'package:remote_portal/features/characters/domain/entities/character.dart';

class CharactersState {
  final List<Character> characters;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;
  final String? loadMoreError;

  CharactersState({
    required this.characters,
    required this.currentPage,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  CharactersState copyWith({
    List<Character>? characters,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    String? loadMoreError,
    bool clearLoadMoreError = false,
  }) {
    return CharactersState(
      characters: characters ?? this.characters,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: clearLoadMoreError
          ? null
          : (loadMoreError ?? this.loadMoreError),
    );
  }
}
