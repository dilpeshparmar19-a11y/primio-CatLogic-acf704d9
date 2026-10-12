enum CellState { empty, marked, cat }

class CellData {
  final int row;
  final int col;
  final int regionIndex;
  CellState state;
  final bool hasCatSolution;

  CellData({
    required this.row,
    required this.col,
    required this.regionIndex,
    this.state = CellState.empty,
    this.hasCatSolution = false,
  });

  CellData copyWith({CellState? state}) => CellData(
        row: row,
        col: col,
        regionIndex: regionIndex,
        state: state ?? this.state,
        hasCatSolution: hasCatSolution,
      );
}

class PuzzleData {
  final int size;
  final List<List<CellData>> grid;
  final int totalCats;

  const PuzzleData({
    required this.size,
    required this.grid,
    required this.totalCats,
  });
}

class LevelConfig {
  final int level;
  final int gridSize;
  final String title;

  const LevelConfig({
    required this.level,
    required this.gridSize,
    required this.title,
  });
}
