import 'dart:math';

import 'package:primio_app/models/puzzle_model.dart';

class PuzzleService {
  final _random = Random();

  List<LevelConfig> getLevels() {
    return [
      const LevelConfig(level: 1, gridSize: 5, title: 'Level 1'),
      const LevelConfig(level: 2, gridSize: 5, title: 'Level 2'),
      const LevelConfig(level: 3, gridSize: 5, title: 'Level 3'),
      const LevelConfig(level: 4, gridSize: 6, title: 'Level 4'),
      const LevelConfig(level: 5, gridSize: 6, title: 'Level 5'),
      const LevelConfig(level: 6, gridSize: 6, title: 'Level 6'),
      const LevelConfig(level: 7, gridSize: 7, title: 'Level 7'),
      const LevelConfig(level: 8, gridSize: 7, title: 'Level 8'),
      const LevelConfig(level: 9, gridSize: 7, title: 'Level 9'),
      const LevelConfig(level: 10, gridSize: 8, title: 'Level 10'),
    ];
  }

  PuzzleData generatePuzzle(int size) {
    // Place N cats on NxN grid: one per row, one per col, no diagonal touching
    final catPositions = _placeCats(size);
    // Generate regions
    final regionMap = _generateRegions(size, catPositions);
    // Build grid
    final grid = List.generate(size, (r) {
      return List.generate(size, (c) {
        final isCat = catPositions.any((p) => p[0] == r && p[1] == c);
        return CellData(
          row: r,
          col: c,
          regionIndex: regionMap[r][c],
          hasCatSolution: isCat,
        );
      });
    });
    return PuzzleData(size: size, grid: grid, totalCats: size);
  }

  List<List<int>> _placeCats(int size) {
    // Use backtracking to place cats
    for (int attempt = 0; attempt < 100; attempt++) {
      final result = <List<int>>[];
      final cols = List.generate(size, (i) => i)..shuffle(_random);
      bool valid = true;

      for (int row = 0; row < size; row++) {
        final col = cols[row];
        // Check diagonal adjacency with all placed cats
        bool diagConflict = false;
        for (final placed in result) {
          if ((placed[0] - row).abs() <= 1 && (placed[1] - col).abs() <= 1) {
            diagConflict = true;
            break;
          }
        }
        if (diagConflict) {
          valid = false;
          break;
        }
        result.add([row, col]);
      }
      if (valid && result.length == size) return result;
    }
    // Fallback: use backtracking solver
    return _backtrackPlace(size);
  }

  List<List<int>> _backtrackPlace(int size) {
    final result = <List<int>>[];
    final usedCols = <int>{};

    bool solve(int row) {
      if (row == size) return true;
      final colOrder = List.generate(size, (i) => i)..shuffle(_random);
      for (final col in colOrder) {
        if (usedCols.contains(col)) continue;
        bool diagOk = true;
        for (final p in result) {
          if ((p[0] - row).abs() <= 1 && (p[1] - col).abs() <= 1) {
            diagOk = false;
            break;
          }
        }
        if (!diagOk) continue;
        result.add([row, col]);
        usedCols.add(col);
        if (solve(row + 1)) return true;
        result.removeLast();
        usedCols.remove(col);
      }
      return false;
    }

    solve(0);
    return result;
  }

  List<List<int>> _generateRegions(int size, List<List<int>> catPositions) {
    // Each cat seeds a region; grow regions via flood fill
    final regionMap = List.generate(size, (_) => List.filled(size, -1));

    // Assign each cat cell to its region
    for (int i = 0; i < catPositions.length; i++) {
      regionMap[catPositions[i][0]][catPositions[i][1]] = i;
    }

    // BFS growth: grow all regions simultaneously
    final queues = List.generate(catPositions.length, (i) {
      return <List<int>>[
        [catPositions[i][0], catPositions[i][1]]
      ];
    });

    bool changed = true;
    while (changed) {
      changed = false;
      for (int i = 0; i < queues.length; i++) {
        final nextQueue = <List<int>>[];
        for (final cell in queues[i]) {
          final dirs = [
            [0, 1],
            [0, -1],
            [1, 0],
            [-1, 0]
          ]..shuffle(_random);
          for (final d in dirs) {
            final nr = cell[0] + d[0];
            final nc = cell[1] + d[1];
            if (nr >= 0 && nr < size && nc >= 0 && nc < size && regionMap[nr][nc] == -1) {
              regionMap[nr][nc] = i;
              nextQueue.add([nr, nc]);
              changed = true;
            }
          }
        }
        queues[i] = nextQueue;
      }
    }

    // Fill any remaining -1 cells
    for (int r = 0; r < size; r++) {
      for (int c = 0; c < size; c++) {
        if (regionMap[r][c] == -1) {
          regionMap[r][c] = _random.nextInt(catPositions.length);
        }
      }
    }

    return regionMap;
  }

  /// Returns true if placing a cat at [row],[col] is the correct solution
  bool isCatCorrect(PuzzleData puzzle, int row, int col) {
    return puzzle.grid[row][col].hasCatSolution;
  }

  /// Check if puzzle is solved (all cats found)
  bool isPuzzleSolved(PuzzleData puzzle) {
    for (final row in puzzle.grid) {
      for (final cell in row) {
        if (cell.hasCatSolution && cell.state != CellState.cat) return false;
      }
    }
    return true;
  }

  int countPlacedCats(PuzzleData puzzle) {
    int count = 0;
    for (final row in puzzle.grid) {
      for (final cell in row) {
        if (cell.state == CellState.cat) count++;
      }
    }
    return count;
  }
}
