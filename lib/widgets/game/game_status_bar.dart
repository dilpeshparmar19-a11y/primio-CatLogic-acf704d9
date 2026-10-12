import 'package:flutter/material.dart';
import 'package:primio_app/theme/theme.dart';

class GameStatusBar extends StatelessWidget {
  final int placedCats;
  final int totalCats;
  final int lives;

  const GameStatusBar({
    super.key,
    required this.placedCats,
    required this.totalCats,
    required this.lives,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLg,
        vertical: AppTheme.spacingMd,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: appColors.chipBorder, width: AppTheme.borderDefault),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🐱', style: TextStyle(fontSize: 20)),
              const SizedBox(width: AppTheme.spacingSm),
              Text(
                '$placedCats / $totalCats placed',
                style: text.titleMedium,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (i) {
              return Padding(
                padding: EdgeInsets.only(left: i > 0 ? AppTheme.spacingXs : 0),
                child: Icon(
                  i < lives ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: i < lives ? appColors.danger : appColors.subtleText,
                  size: AppTheme.iconMd,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
