import 'package:flutter/material.dart';
import '../../data/models/album.dart';

class AlbumListItem extends StatelessWidget {
  final Album album;
  final VoidCallback onTap;

  const AlbumListItem({
    super.key,
    required this.album,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          album.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text('Album ID: ${album.id}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
} 