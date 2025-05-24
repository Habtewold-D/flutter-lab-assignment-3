import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/albums/albums_bloc.dart';
import '../bloc/albums/albums_event.dart';
import '../bloc/albums/albums_state.dart';
import '../widgets/album_list_item.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: BlocBuilder<AlbumsBloc, AlbumsState>(
        builder: (context, state) {
          if (state is AlbumsInitial) {
            context.read<AlbumsBloc>().add(LoadAlbums());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AlbumsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AlbumsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AlbumsBloc>().add(LoadAlbums());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is AlbumsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AlbumsBloc>().add(RefreshAlbums());
              },
              child: ListView.builder(
                itemCount: state.albums.length,
                itemBuilder: (context, index) {
                  final album = state.albums[index];
                  return AlbumListItem(
                    album: album,
                    onTap: () {
                      context.go('/album/${album.id}');
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
} 