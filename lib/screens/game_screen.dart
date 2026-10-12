import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:primio_app/providers/game_provider.dart';
import 'package:primio_app/theme/theme.dart';
import 'package:primio_app/widgets/game/game_board.dart';
import 'package:primio_app/widgets/game/game_over_overlay.dart';
import 'package:primio_app/widgets/game/game_rules_bar.dart';
import 'package:primio_app/widgets/game/game_status_bar.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    final theme = Theme.of(context);
    final text = theme.textTheme;

    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: colors.onSurface),
          onPressed: () => context.go('/'),
        ),
        title: Text(
          provider.levelConfig.title,
          style: text.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded, color: colors.primary),
            onPressed: provider.restart,
          ),
          const SizedBox(width: AppTheme.spacingXs),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
              child: Column(
                children: [
                  const SizedBox(height: AppTheme.spacingSm),
                  GameStatusBar(
                    placedCats: provider.placedCats,
                    totalCats: provider.totalCats,
                    lives: provider.lives,
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  const GameRulesBar(),
                  const SizedBox(height: AppTheme.spacingLg),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: GameBoard(
                          puzzle: provider.puzzle,
                          onCellTap: provider.onCellTap,
                          onCellDoubleTap: provider.onCellDoubleTap,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd,
                      vertical: AppTheme.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: theme.extension<AppColorsExtension>()!.chipBackground,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    ),
                    child: Text(
                      'Tap to mark ✕  •  Double-tap to place 🐱',
                      style: text.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                ],
              ),
            ),
          ),
          if (provider.status != GameStatus.playing)
            GameOverOverlay(
              status: provider.status,
              onRestart: provider.restart,
              onHome: () => context.go('/'),
            ),
        ],
      ),
    );
  }
}
