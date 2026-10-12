import 'package:flutter/material.dart';
import 'package:primio_app/theme/theme.dart';

class GameRulesBar extends StatelessWidget {
  const GameRulesBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;

    final appColors = theme.extension<AppColorsExtension>()!;

    return Row(
      children: [
        Expanded(
          child: _RuleChip(
            icon: Icons.palette_rounded,
            label: '1 per color',
            theme: theme,
            textTheme: text,
            appColors: appColors,
          ),
        ),
        const SizedBox(width: AppTheme.spacingSm),
        Expanded(
          child: _RuleChip(
            icon: Icons.grid_on_rounded,
            label: '1 per row/col',
            theme: theme,
            textTheme: text,
            appColors: appColors,
          ),
        ),
        const SizedBox(width: AppTheme.spacingSm),
        Expanded(
          child: _RuleChip(
            icon: Icons.block_rounded,
            label: 'No touching',
            theme: theme,
            textTheme: text,
            appColors: appColors,
          ),
        ),
      ],
    );
  }
}

class _RuleChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final ThemeData theme;
  final TextTheme textTheme;
  final AppColorsExtension appColors;

  const _RuleChip({
    required this.icon,
    required this.label,
    required this.theme,
    required this.textTheme,
    required this.appColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingSm,
        vertical: AppTheme.spacingSm,
      ),
      decoration: BoxDecoration(
        color: appColors.chipBackground,
        border: Border.all(
          color: appColors.chipBorder,
          width: AppTheme.borderDefault,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppTheme.iconSm, color: theme.colorScheme.primary),
          const SizedBox(height: AppTheme.spacingXs / 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
