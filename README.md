# Zero Yield

A fork of [Infinite Yield](https://github.com/EdgeIY/infiniteyield) designed to provide a better experience.
It's faster, cleaner, and easier to maintain.

> [!CAUTION]
> This fork is still in development, expect bugs.

## Loadstrings

### Stable

```luau
loadstring(game:HttpGet("https://github.com/zero-yield/zero-yield/releases/latest/download/source.min.luau"))()
```

### Beta

```luau
loadstring(game:HttpGet("https://raw.githubusercontent.com/zero-yield/zero-yield/refs/heads/builds/source.min.luau"))()
```

## Note on custom plugins

Plugins for Zero Yield use the `.zy` extension to avoid confusion with Infinite Yield plugins. To port an existing `.iy` plugin, simply rename the file to `.zy`.

## Development

### Prerequisites

Install [Rokit](https://github.com/rojo-rbx/rokit) to manage project tools (selene, StyLua, darklua):

```bash
rokit install
```

### Build

Bundle the modules into single-file release builds via [DarkLua](https://github.com/seaofvoices/darklua):

```bash
node scripts/release.js
```

This produces `dist/source.luau` (readable) and `dist/source.min.luau` (minified).

Bump the version and keep it in sync across files in one step:

```bash
node scripts/update-version.js 6.6.1
```

### Git hooks

This project uses [pre-commit](https://pre-commit.com) to format and lint code automatically on every commit.

```bash
pip install pre-commit
pre-commit install
```

After setup, `stylua` and `selene` run against the staged `.luau` files before each commit. The StyLua hook uses the system binary (via Rokit) so it gains full Luau support.

### Manual checks

```bash
stylua src/ --check
selene src/
```

## Linting

This project uses [selene](https://kampfkarren.github.io/selene/) for Lua linting with a custom standard library (`roblox_exploit.yml`) that extends the Roblox std lib with exploit-specific globals (e.g. `getgenv`, `cloneref`, `writefile`).

To run the linter locally:

```bash
selene src/
```

A GitHub Actions workflow (`.github/workflows/lint.yml`) runs selene and StyLua automatically on pushes and pull requests to `master` and `next`.

## Credits

This project is based on the original work by [EdgeIY](https://github.com/EdgeIY). The original project can be found [here](https://github.com/EdgeIY/infiniteyield).
