import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:realm/realm.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/features/favorites/bloc/favorite_rhymes_bloc.dart';
import 'package:rhymer/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer/features/search/bloc/rhymer_list_bloc.dart';
import 'package:rhymer/repositories/favorites/favorites.dart';
import 'package:rhymer/repositories/history/history.dart';
import 'package:rhymer/router/router.dart';

import 'ui/ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  //final client = RhymerApiClient.create(apiURL: dotenv.env['API_URL']);
  final config =
      Configuration.local([HistoryRhymes.schema, FavoriteRhymes.schema]);

  final realm = Realm(config);
  runApp(RhymerApp(realm: realm));
}

class RhymerApp extends StatefulWidget {
  const RhymerApp({
    super.key,
    required this.realm,
  });

  final Realm realm;

  @override
  State<RhymerApp> createState() => _RhymerAppState();
}

class _RhymerAppState extends State<RhymerApp> {
  final _router = AppRouter();

  // @override
  // void initState() {
  //   super.initState();
  //   // widget.apiClient.getRhimesList('морковь').then((value) {
  //   //   print(value);
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    final historyRepository = HistoryRepository(realm: widget.realm);
    final favoritesRepository = FavoritesRepository(realm: widget.realm);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RhymesListBloc(
            apiClient: RhymerApiClient.create(apiUrl: dotenv.env['API_URL']),
            historyRepository: historyRepository,
            favoritesRepository: favoritesRepository,
          ),
        ),
        BlocProvider(
          create: (context) => HistoryRhymesBloc(
            historyRepository: historyRepository,
          ),
        ),
        BlocProvider(
          create: (context) => FavoriteRhymesBloc(
            favoritesRepository: favoritesRepository,
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Rhymer',
        theme: themeData,
        routerConfig: _router.config(),
      ),
    );
  }
}
