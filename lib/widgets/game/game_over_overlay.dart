import 'package:flutter/material.dart';
import 'package:primio_app/providers/game_provider.dart';
import 'package:primio_app/theme/theme.dart';

class GameOverOverlay extends StatelessWidget {
  final GameStatus status;
  final VoidCallback onRestart;
  final VoidCallback onHome;

  const GameOverOverlay({
    super.key,
    required this.status,
    required this.onRestart,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;
    final isWin = status == GameStatus.won;

    return Container(
      color: colors.onSurface.withValues(alpha: AppTheme.opacityOverlay),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(AppTheme.spacingXl),
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            boxShadow: [
              BoxShadow(
                color: colors.onSurface.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isWin ? '🎉' : '😿',
                style: const TextStyle(fontSize: 56),
              ),
              const SizedBox(height: AppTheme.spacingMd),
              Text(
                isWin ? 'Purr-fect!' : 'Game Over',
                style: text.headlineMedium,
              ),
              const SizedBox(height: AppTheme.spacingSm),
              Text(
                isWin
                    ? 'You found all the cats!'
                    : 'You ran out of lives.',
                style: text.bodyMedium?.copyWith(
                  color: appColors.subtleText,
                ),
              ),
              const SizedBox(height: AppTheme.spacingLg),
              ElevatedButton.icon(
                onPressed: onRestart,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(isWin ? 'Next Puzzle' : 'Try Again'),
              ),
              const SizedBox(height: AppTheme.spacingSm),
              TextButton(
                onPressed: onHome,
                child: Text(
                  'Back to Levels',
                  style: text.labelLarge?.copyWith(color: colors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
