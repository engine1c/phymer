import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/api/models/models.dart';

part 'rhymer_list_event.dart';
part 'rhymer_list_state.dart';

class RhymesListBloc extends Bloc<RhymesListEvent, RhymesListState> {
  RhymesListBloc({required this.apiClient}) : super(RhymesListInitial()) {
    on<SearchRhymes>(_onSearch);
  }

  final RhymerApiClient apiClient;

  Future<void> _onSearch(
    SearchRhymes event,
    Emitter<RhymesListState> emit,
  ) async {
    try {
      emit(RhymesListLoading());
      final rhymes = await apiClient.getRhimesList(event.query);
      emit(RhymesListLoaded(rhymes: rhymes));
      //print('....Rhymer---List---Loading$rhymes');
    } catch (e) {
      //print('....Rhymer---List---Loading---ERROR: $e');
      emit(RhymesListFailure(e));
    }
  }
}
