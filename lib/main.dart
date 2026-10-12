import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:primio_app/router/app_router.dart';
import 'package:primio_app/services/puzzle_service.dart';
import 'package:primio_app/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => PuzzleService()),
      ],
      child: MaterialApp.router(
        title: 'Cat Logic',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}