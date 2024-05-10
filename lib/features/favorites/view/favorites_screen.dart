import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rhymer/features/search/widgets/widgets.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

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
          SliverList.builder(
              itemBuilder: (context, index) => const RhymeListCard(
                    rhyme: 'Рифма',
                    sourseWord: 'SLOVO',
                    isFavorite: true,
                  )),
        ],
      ),
    );
  }
}
