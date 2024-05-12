import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rhymer/api/api.dart';
//import 'package:rhymer/api/api.dart';
import 'package:rhymer/router/router.dart';

import 'ui/ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final client = RhimerApiClient.create(apiURL: dotenv.env['API_URL']);
  runApp(const RhymerApp());
}

class RhymerApp extends StatefulWidget {
  const RhymerApp({
    super.key,
  });
  //final RhimerApiClient apiClient;

  @override
  State<RhymerApp> createState() => _RhymerAppState();
}

class _RhymerAppState extends State<RhymerApp> {
  final _router = AppRouter();

  @override
  void initState() {
    super.initState();
    // widget.apiClient.getRhimesList('морковь').then((value) {
    //   print(value);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rhymer',
      theme: themeData,
      routerConfig: _router.config(),
    );
  }
}
