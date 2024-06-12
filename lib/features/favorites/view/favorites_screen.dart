import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/features/favorites/bloc/favorite_rhymes_bloc.dart';
import 'package:rhymer/features/search/bloc/rhymer_list_bloc.dart';
import 'package:rhymer/repositories/favorites/model/model.dart';
import 'package:rhymer/ui/widgets/widgets.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoriteRhymesBloc>(context).add(LoadFavoriteRhymes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Избранное'),
            //backgroundColor:  theme.primaryColor,
            pinned: true,
            snap: true,
            floating: true,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 16,
          )),
          BlocBuilder<FavoriteRhymesBloc, FavoriteRhymesState>(
              builder: (context, state) {
            if (state is FavoriteRhymesLoaded) {
              return SliverList.builder(
                itemCount: state.rhymes.length,
                itemBuilder: (context, index) {
                  final rhyme = state.rhymes[index];
                  return RhymeListCard(
                      rhyme: rhyme.favoriteWord,
                      sourceWord: rhyme.queryWord,
                      isFavorite: true,
                      onTap: () {
                        _toggleFavoriteRhyme(context, rhyme);
                      });
                },
              );
            }
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
        ],
      ),
    );
  }

  void _toggleFavoriteRhyme(BuildContext context, FavoriteRhymes rhyme) {
    BlocProvider.of<FavoriteRhymesBloc>(context)
        .add(ToggleFavoriteRhyme(rhyme));
    BlocProvider.of<RhymesListBloc>(context).add(UpdateFavorites());
  }
}
