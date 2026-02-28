# Changelog

## [1.0.2] - 2026-02-28

### 🛠 Fix
- Default scroll physics behavior.

## [1.0.1] - 2025-05-17

### ✨ Added
- `axis` parameter added to support both vertical and horizontal scrolling.
- `.builder` constructor added for efficient lazy loading and dynamic item generation.
- `physics` support added to allow custom scroll behavior.
- `controller`, `shrinkWrap`, `padding`, and `mainAxisAlignment` parameters added for more flexibility.

### 💡 Improvements
- Widgets are now grouped evenly using modulo logic for balanced distribution.
- Introduced `.insertSeparators()` extension for elegant spacing between columns/rows.
- Clean, flexible layout engine that adapts to vertical or horizontal direction.

## [1.0.0] - Initial release
- Basic vertical grid with fixed children and spacing.