import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:primio_app/services/puzzle_service.dart';
import 'package:primio_app/theme/theme.dart';
import 'package:primio_app/widgets/home/level_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;
    final service = context.read<PuzzleService>();
    final levels = service.getLevels();

    final appColors = theme.extension<AppColorsExtension>()!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingLg,
                AppTheme.spacingMd,
                AppTheme.spacingLg,
                0,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg,
                  vertical: AppTheme.spacingXl,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [appColors.headerGradientStart, appColors.headerGradientEnd],
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  boxShadow: [
                    BoxShadow(
                      color: appColors.headerGradientEnd.withValues(alpha: AppTheme.opacityHint * 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: appColors.onHeaderGradient.withValues(alpha: AppTheme.opacityHint * 0.35),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text('🐾', style: TextStyle(fontSize: 34)),
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    Text(
                      'Cat Logic',
                      style: text.headlineLarge?.copyWith(
                        color: appColors.onHeaderGradient,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXs),
                    Text(
                      'Find the purrfect spot for every cat',
                      textAlign: TextAlign.center,
                      style: text.bodyMedium?.copyWith(
                        color: appColors.onHeaderGradient.withValues(alpha: AppTheme.opacityHint + 0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacingLg,
                  AppTheme.spacingLg,
                  AppTheme.spacingLg,
                  AppTheme.spacingMd,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Choose a Level', style: text.titleLarge),
                        Text(
                          '${levels.length} puzzles',
                          style: text.labelMedium?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: AppTheme.spacingMd,
                          crossAxisSpacing: AppTheme.spacingMd,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: levels.length,
                        itemBuilder: (context, index) {
                          return LevelCard(
                            config: levels[index],
                            index: index,
                            onTap: () => context.go('/game/$index'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
