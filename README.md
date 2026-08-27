# Zero Yield

A fork of Infinite Yield designed to provide a better experience.

> [!CAUTION]
> This fork is still in development. Expect bugs!

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

Plugins for Zero Yield are `.zy` files to avoid confusion with Infinite Yield plugins. If you are using an `.iy` file and want to port it to Zero Yield, simply rename the file extension to: `.zy`.

## Development

### Prerequisites

Install [Rokit](https://github.com/rojo-rbx/rokit) to manage project tools (selene, StyLua).

```bash
rokit install
```

### Git hooks

This project uses [pre-commit](https://pre-commit.com) to lint and format code automatically on each commit.

```bash
pip install pre-commit
pre-commit install
```

After setup, `stylua` and `selene` will run on staged `.luau` files before every commit.

### Manual checks

```bash
stylua --check source
selene source
```

## Linting

This project uses [selene](https://kampfkarren.github.io/selene/) for Lua linting with a custom standard library (`roblox_exploit.yml`) that extends the Roblox std lib with exploit-specific globals (e.g. `getgenv`, `cloneref`, `writefile`).

To run the linter locally:

```bash
selene source
```

A GitHub Actions workflow (`.github/workflows/lint.yml`) runs selene automatically on pushes and pull requests.

## Credits

This project is based on the original work by [EdgeIY](https://github.com/EdgeIY). The original project can be found [here](https://github.com/EdgeIY/infiniteyield).
