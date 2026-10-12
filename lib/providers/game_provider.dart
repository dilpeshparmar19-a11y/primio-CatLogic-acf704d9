import 'package:flutter/material.dart';
import 'package:primio_app/models/puzzle_model.dart';
import 'package:primio_app/services/puzzle_service.dart';

enum GameStatus { playing, won, lost }

class GameProvider extends ChangeNotifier {
  final PuzzleService _service;
  final LevelConfig levelConfig;

  late PuzzleData _puzzle;
  PuzzleData get puzzle => _puzzle;

  int _lives = 3;
  int get lives => _lives;

  GameStatus _status = GameStatus.playing;
  GameStatus get status => _status;

  int get placedCats => _service.countPlacedCats(_puzzle);
  int get totalCats => _puzzle.totalCats;

  GameProvider({
    required PuzzleService service,
    required this.levelConfig,
  }) : _service = service {
    _puzzle = _service.generatePuzzle(levelConfig.gridSize);
  }

  void onCellTap(int row, int col) {
    if (_status != GameStatus.playing) return;
    final cell = _puzzle.grid[row][col];

    if (cell.state == CellState.empty) {
      cell.state = CellState.marked;
    } else if (cell.state == CellState.marked) {
      cell.state = CellState.empty;
    }
    notifyListeners();
  }

  void onCellDoubleTap(int row, int col) {
    if (_status != GameStatus.playing) return;
    final cell = _puzzle.grid[row][col];

    if (cell.state == CellState.cat) {
      // Remove cat (shouldn't normally happen but allow undo)
      cell.state = CellState.empty;
      notifyListeners();
      return;
    }

    // Place cat
    if (_service.isCatCorrect(_puzzle, row, col)) {
      cell.state = CellState.cat;
      // Auto-mark adjacent cells
      _autoMarkAround(row, col);
      if (_service.isPuzzleSolved(_puzzle)) {
        _status = GameStatus.won;
      }
    } else {
      _lives--;
      // Briefly show wrong, then reset
      cell.state = CellState.marked;
      if (_lives <= 0) {
        _status = GameStatus.lost;
      }
    }
    notifyListeners();
  }

  void _autoMarkAround(int row, int col) {
    final size = _puzzle.size;
    // Mark entire row and column
    for (int c = 0; c < size; c++) {
      if (c != col && _puzzle.grid[row][c].state == CellState.empty) {
        _puzzle.grid[row][c].state = CellState.marked;
      }
    }
    for (int r = 0; r < size; r++) {
      if (r != row && _puzzle.grid[r][col].state == CellState.empty) {
        _puzzle.grid[r][col].state = CellState.marked;
      }
    }
    // Mark diagonals
    for (int dr = -1; dr <= 1; dr++) {
      for (int dc = -1; dc <= 1; dc++) {
        if (dr == 0 && dc == 0) continue;
        final nr = row + dr;
        final nc = col + dc;
        if (nr >= 0 && nr < size && nc >= 0 && nc < size) {
          if (_puzzle.grid[nr][nc].state == CellState.empty) {
            _puzzle.grid[nr][nc].state = CellState.marked;
          }
        }
      }
    }
  }

  void restart() {
    _puzzle = _service.generatePuzzle(levelConfig.gridSize);
    _lives = 3;
    _status = GameStatus.playing;
    notifyListeners();
  }
}
