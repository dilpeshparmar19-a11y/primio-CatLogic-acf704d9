import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primio_app/models/puzzle_model.dart';
import 'package:primio_app/theme/theme.dart';

class GameCell extends StatelessWidget {
  final CellData cell;
  final double size;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final bool showTopBorder;
  final bool showLeftBorder;
  final bool showBottomBorder;
  final bool showRightBorder;

  const GameCell({
    super.key,
    required this.cell,
    required this.size,
    required this.onTap,
    required this.onDoubleTap,
    this.showTopBorder = false,
    this.showLeftBorder = false,
    this.showBottomBorder = false,
    this.showRightBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final regionColor = AppTheme.regionColors[cell.regionIndex % AppTheme.regionColors.length];
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      onDoubleTap: () {
        HapticFeedback.mediumImpact();
        onDoubleTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: cell.state == CellState.cat
              ? regionColor
              : regionColor.withValues(alpha: AppTheme.opacityHint),
          border: Border(
            top: showTopBorder
                ? BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.3), width: AppTheme.borderSelected)
                : BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.08), width: AppTheme.borderDefault),
            left: showLeftBorder
                ? BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.3), width: AppTheme.borderSelected)
                : BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.08), width: AppTheme.borderDefault),
            bottom: showBottomBorder
                ? BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.3), width: AppTheme.borderSelected)
                : BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.08), width: AppTheme.borderDefault),
            right: showRightBorder
                ? BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.3), width: AppTheme.borderSelected)
                : BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.08), width: AppTheme.borderDefault),
          ),
        ),
        child: Center(child: _buildCellContent(theme)),
      ),
    );
  }

  Widget _buildCellContent(ThemeData theme) {
    switch (cell.state) {
      case CellState.empty:
        return const SizedBox.shrink();
      case CellState.marked:
        return Icon(
          Icons.close_rounded,
          size: size * 0.4,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
        );
      case CellState.cat:
        return Text(
          '🐱',
          style: TextStyle(fontSize: size * 0.45),
        );
    }
  }
}
