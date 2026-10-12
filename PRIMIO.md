# Cat Logic

## Overview
A cat-themed logic puzzle game inspired by Meowdoku. Players place cats on a colored grid following three rules: one cat per colored region, one cat per row/column, and no diagonal touching. Targets casual puzzle fans who enjoy Sudoku-style deduction.

## Tech Stack & Key Decisions
- Provider + ChangeNotifier for state — simple game state fits single-provider-per-screen pattern
- go_router for navigation — clean level selection to game screen transitions
- PuzzleService generates puzzles via backtracking algorithm with randomized region growth
- No persistence yet — levels regenerate each play; SharedPreferences available for future save state
- google_fonts (Nunito) for warm, friendly typography matching the cat theme

## Architecture
- PuzzleService handles all puzzle generation, validation, and solution checking
- GameProvider is route-scoped: created fresh per level, auto-disposed on navigation
- PuzzleService is app-global (stateless) provided in main.dart
- Models are pure data: CellData, PuzzleData, LevelConfig with no logic

## Conventions
- Region colors defined in AppTheme.regionColors — indexed by regionIndex modulo length
- Cell interactions: single tap toggles mark (X), double tap places cat
- Auto-marking: when cat is correctly placed, entire row/column and diagonals are auto-marked
- Game over overlay pattern: Stack-based centered overlay, not inline widget

## Key Patterns & Gotchas
- Puzzle generation uses shuffled backtracking — may produce different difficulties; no difficulty scoring yet
- Region generation uses simultaneous BFS growth from cat positions — ensures each region contains exactly one cat
- Cell borders are thicker between different regions to visually separate them
- Lives only decrease on incorrect double-tap (cat placement), not on mark toggling

## Design System
- Warm, soft aesthetic with pastel region colors on cream background — inviting for casual puzzle players
- Nunito font family throughout for rounded, friendly feel
- Primary color is warm coral (#FF8C6B) — energetic but not aggressive
- 8px spacing grid; cards use 16px radius; board uses subtle shadow for depth
