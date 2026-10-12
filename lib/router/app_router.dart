import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:primio_app/providers/game_provider.dart';
import 'package:primio_app/screens/game_screen.dart';
import 'package:primio_app/screens/home_screen.dart';
import 'package:primio_app/services/puzzle_service.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/game/:level',
        pageBuilder: (context, state) {
          final levelIndex = int.parse(state.pathParameters['level']!);
          final service = context.read<PuzzleService>();
          final levels = service.getLevels();
          final config = levels[levelIndex.clamp(0, levels.length - 1)];

          return CustomTransitionPage(
            child: ChangeNotifierProvider(
              create: (_) => GameProvider(service: service, levelConfig: config),
              child: const GameScreen(),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.05),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
                  child: child,
                ),
              );
            },
          );
        },
      ),
    ],
  );
}
