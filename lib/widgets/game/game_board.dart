import 'package:flutter/material.dart';
import 'package:primio_app/models/puzzle_model.dart';
import 'package:primio_app/theme/theme.dart';
import 'package:primio_app/widgets/game/game_cell.dart';

class GameBoard extends StatelessWidget {
  final PuzzleData puzzle;
  final void Function(int row, int col) onCellTap;
  final void Function(int row, int col) onCellDoubleTap;

  const GameBoard({
    super.key,
    required this.puzzle,
    required this.onCellTap,
    required this.onCellDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        const padding = AppTheme.spacingXs;
        final boardSize = constraints.maxWidth - padding * 2;
        final cellSize = boardSize / puzzle.size;

        return Container(
          decoration: BoxDecoration(
            color: appColors.boardBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(padding),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(puzzle.size, (row) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(puzzle.size, (col) {
                    final cell = puzzle.grid[row][col];
                    return GameCell(
                      cell: cell,
                      size: cellSize,
                      onTap: () => onCellTap(row, col),
                      onDoubleTap: () => onCellDoubleTap(row, col),
                      showTopBorder: row > 0 && puzzle.grid[row - 1][col].regionIndex != cell.regionIndex,
                      showLeftBorder: col > 0 && puzzle.grid[row][col - 1].regionIndex != cell.regionIndex,
                      showBottomBorder: row < puzzle.size - 1 && puzzle.grid[row + 1][col].regionIndex != cell.regionIndex,
                      showRightBorder: col < puzzle.size - 1 && puzzle.grid[row][col + 1].regionIndex != cell.regionIndex,
                    );
                  }),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
