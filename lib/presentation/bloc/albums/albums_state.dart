import 'package:equatable/equatable.dart';
import '../../../data/models/album.dart';

abstract class AlbumsState extends Equatable {
  const AlbumsState();

  @override
  List<Object?> get props => [];
}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsLoaded extends AlbumsState {
  final List<Album> albums;

  const AlbumsLoaded(this.albums);

  @override
  List<Object?> get props => [albums];
}

class AlbumsError extends AlbumsState {
  final String message;

  const AlbumsError(this.message);

  @override
  List<Object?> get props => [message];
} 