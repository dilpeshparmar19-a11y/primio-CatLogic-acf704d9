import 'package:flutter/material.dart';
import 'package:primio_app/models/puzzle_model.dart';
import 'package:primio_app/theme/theme.dart';

class LevelCard extends StatelessWidget {
  final LevelConfig config;
  final int index;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.config,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;
    final regionColor = AppTheme.regionColors[index % AppTheme.regionColors.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(
            color: colors.outlineVariant.withValues(alpha: AppTheme.opacityHint * 0.5),
            width: AppTheme.borderDefault,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.onSurface.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: regionColor.withValues(alpha: AppTheme.opacityHint),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text('🐱', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Text(
              config.title,
              style: text.titleSmall?.copyWith(
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXs / 2),
            Text(
              '${config.gridSize}×${config.gridSize}',
              style: text.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
