import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:remote_portal/features/characters/presentation/screens/character_detail_screen.dart';
import 'package:remote_portal/features/characters/presentation/screens/characters_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'characters',
        builder: (context, state) => const CharactersScreen(),
        routes: [
          GoRoute(
            path: 'character/:id',
            name: 'character-detail',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              return CharacterDetailScreen(characterId: id);
            },
          ),
        ],
      ),
    ],
  );
});
