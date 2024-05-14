import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer/features/search/bloc/rhymer_list_bloc.dart';
import 'package:rhymer/features/search/widgets/rhymes_list_initial_baner.dart';
import 'package:rhymer/features/search/widgets/widgets.dart';
import 'package:rhymer/ui/widgets/widgets.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

// final apiURL = dotenv.env['API_URL'];
// final client = RhymerApiClient.create(apiURL: apiURL);
// final _rhymesListBloc = RhymesListBloc(apiClient: client);

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  // @override
  // void initState() {
  //   //_rhymesListBloc.add(const SearchRhymes(query: 'глаз'));
  //   BlocProvider.of<RhymesListBloc>(context)
  //       .add(const SearchRhymes(query: 'морковь'));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Поиск'),
          //backgroundColor:  theme.primaryColor,
          pinned: true,
          snap: true,
          floating: true,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: SearchButton(
              controller: _searchController,
              onTap: () => _showSearchBottomSheet(context),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(
                width: 16,
              ),
              itemBuilder: (context, index) {
                final rhymes = List.generate(8, (index) => 'Рифма$index');
                return RhymeHistoryCard(rhymes: rhymes);
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        BlocBuilder<RhymesListBloc, RhymesListState>(
            //listener: _handleRhymesListState,
            builder: (context, state) {
          if (state is RhymesListLoaded) {
            final rhymesModel = state.rhymes;
            final rhymes = rhymesModel.words;
            return SliverList.builder(
              itemCount: rhymes.length,
              itemBuilder: (context, index) {
                final rhyme = rhymes[index];
                return RhymeListCard(
                    rhyme: rhyme,
                    //isFavorite: state.isFavorite(rhyme),
                    onTap: () {}
                    //=> _toggleFavorite(context, rhymesModel, state, rhyme),
                    );
              },
            );
          }
          if (state is RhymesListInitial) {
            return const SliverFillRemaining(
              child: RhymesListInitialBanner(),
            );
          }
          return const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
      ],
    );
  }

  // void _handleRhymesListState(
  //   BuildContext context,
  //   RhymesListState state,
  // ) {
  //   if (state is RhymesListLoaded) {
  //     BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
  //   }
  // }

  Future<void> _showSearchBottomSheet(BuildContext context) async {
    final bloc = BlocProvider.of<RhymesListBloc>(context);
    final query = await showModalBottomSheet<String>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 60),
        child: SearchRhymesBottomSheet(
          controller: _searchController,
        ),
      ),
    );
    if (query?.isNotEmpty ?? false) {
      bloc.add(SearchRhymes(query: query!));
    }
  }
}
