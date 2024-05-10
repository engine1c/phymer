import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rhymer/ui/widgets/widgets.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('История'),
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
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return const RhymeHistoryCard(rhymes: [
                    'rhymes1',
                    'rhymes2',
                    'rhymes3',
                    'rhymes4',
                    'rhymes5',
                    'rhymes6',
                    'rhymes7',
                  ]);
                  // Container(
                  //   alignment: Alignment.center,
                  //   color: Colors.teal[100 * (index % 9)],
                  //   child: Text('grid item $index'),
                  // );
                },
                childCount: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
