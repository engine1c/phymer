import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/api/models/models.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/repositories/history/history.dart';

part 'rhymer_list_event.dart';
part 'rhymer_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc(
      {required HistoryRepositoryInterface historyRepository,
      required FavoritesRepositoryInterface favoritesRepository,
      required RhymerApiClient apiClient})
      : _historyRepository = historyRepository,
        _favoritesRepository = favoritesRepository,
        _apiClient = apiClient,
        super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
    on<ToggleFavoriteSearch>(_onToggleFavorite);
    on<UpdateFavorites>(_onUpdateFavorites);
  }

  final RhymerApiClient _apiClient;
  final HistoryRepositoryInterface _historyRepository;
  final FavoritesRepositoryInterface _favoritesRepository;

  Future<void> _onUpdateFavorites(
    UpdateFavorites event,
    Emitter<RhymesListState> emit,
  ) async {
    if (state is RhymesListLoaded) {
      final favoriteRhymes = await _favoritesRepository.getRhymesList();
      emit(
          (state as RhymesListLoaded).copyWith(favoriteRhymes: favoriteRhymes));
    }
  }

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await _apiClient.getRhymesList(event.query);
      final historyRhymes = rhymes.toHistory(event.query);
      await _historyRepository.setRhymes(historyRhymes);

      final favoriteRhymes = await _favoritesRepository.getRhymesList();

      emit(RhymesListLoaded(
          rhymes: rhymes, query: event.query, favoriteRhymes: favoriteRhymes));
    } catch (e) {
      emit(RhymesListFailure(e));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteSearch event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      final prevState = state;
      if (prevState is! RhymesListLoaded) {
        log('state is not RhymesListLoaded');
        return;
      }

      await _favoritesRepository.createOrDeleteRhymes(
          event.rhymes.toFavorite(event.query, event.favoriteWord));

      final favoriteRhymes = await _favoritesRepository.getRhymesList();
      emit(prevState.copyWith(favoriteRhymes: favoriteRhymes));
    } catch (e) {
      emit(RhymesListFailure(e));
    } finally {
      event.completer?.complete();
    }
  }
}
