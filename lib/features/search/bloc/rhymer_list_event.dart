part of 'rhymer_list_bloc.dart';

sealed class RhymesListEvent extends Equatable {
  const RhymesListEvent();

  @override
  List<Object?> get props => [];
}

class UpdateFavorites extends RhymesListEvent {}

class SearchRhymes extends RhymesListEvent {
  const SearchRhymes({required this.query});

  final String query;
  @override
  List<Object?> get props => super.props..addAll([query]);
}

class ToggleFavoriteSearch extends RhymesListEvent {
  const ToggleFavoriteSearch({
    required this.rhymes,
    required this.query,
    required this.favoriteWord,
    this.completer,
  });

  final Rhymes rhymes;
  final String favoriteWord;
  final String query;
  final Completer? completer;

  @override
  List<Object?> get props =>
      super.props..addAll([rhymes, favoriteWord, query, completer]);
}
