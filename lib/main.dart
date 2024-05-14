import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rhymer/api/api.dart';
import 'package:rhymer/features/search/bloc/rhymer_list_bloc.dart';
import 'package:rhymer/router/router.dart';

import 'ui/ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  final apiURL = dotenv.env['API_URL'];
  final client = RhymerApiClient.create(apiURL: apiURL);

  runApp(const RhymerApp());
}

class RhymerApp extends StatefulWidget {
  const RhymerApp({
    super.key,
  });

  //final RhymerApiClient apiClient;

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
    return BlocProvider(
      create: (context) => RhymesListBloc(
          apiClient: RhymerApiClient.create(apiURL: dotenv.env['API_URL'])),
      child: MaterialApp.router(
        title: 'Rhymer',
        theme: themeData,
        routerConfig: _router.config(),
      ),
    );
  }
}
