import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/api_service.dart';
import 'albums_event.dart';
import 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final ApiService _apiService;

  AlbumsBloc(this._apiService) : super(AlbumsInitial()) {
    on<LoadAlbums>(_onLoadAlbums);
    on<RefreshAlbums>(_onRefreshAlbums);
  }

  Future<void> _onLoadAlbums(LoadAlbums event, Emitter<AlbumsState> emit) async {
    emit(AlbumsLoading());
    try {
      final albums = await _apiService.getAlbums();
      emit(AlbumsLoaded(albums));
    } catch (e) {
      emit(AlbumsError(e.toString()));
    }
  }

  Future<void> _onRefreshAlbums(RefreshAlbums event, Emitter<AlbumsState> emit) async {
    try {
      final albums = await _apiService.getAlbums();
      emit(AlbumsLoaded(albums));
    } catch (e) {
      emit(AlbumsError(e.toString()));
    }
  }
} 