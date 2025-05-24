import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/album_detail_screen.dart';
import '../screens/albums_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumsScreen(),
    ),
    GoRoute(
      path: '/album/:id',
      builder: (context, state) {
        final albumId = int.parse(state.pathParameters['id']!);
        return AlbumDetailScreen(albumId: albumId);
      },
    ),
  ],
); 