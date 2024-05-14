import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/api/models/models.dart';
import 'package:rhymer/repositories/history/history.dart';

part 'rhymer_list_event.dart';
part 'rhymer_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc(
      {required HistoryRepositoryInterface historyRepository,
      required RhymerApiClient apiClient})
      : _historyRepository = historyRepository,
        _apiClient = apiClient,
        super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
  }

  final RhymerApiClient _apiClient;
  final HistoryRepositoryInterface _historyRepository;

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await _apiClient.getRhimesList(event.query);
      final historyRhymes = rhymes.toHistory(event.query);
      _historyRepository.setRhymes(historyRhymes);
      emit(RhymesListLoaded(rhymes: rhymes));
      //print('....Rhymer---List---Loading$rhymes');
    } catch (e) {
      //print('....Rhymer---List---Loading---ERROR: $e');
      emit(RhymesListFailure(e));
    }
  }
}
