#!/usr/bin/env python3
"""Run project Lua tools from pre-commit, even when they are not on PATH."""

from __future__ import annotations

import os
import shutil
import subprocess
import sys
from pathlib import Path

TOOL_NAMES = {
    "stylua": "StyLua",
    "selene": "selene",
}


def executable_names(tool: str):
    if os.name == "nt":
        yield f"{tool}.exe"
        yield f"{tool}.cmd"
        yield f"{tool}.bat"
    yield tool


def find_tool(tool: str) -> str | None:
    found = shutil.which(tool)
    if found:
        return found

    home = Path.home()
    roots = [
        Path(os.environ.get("ROKIT_HOME", home / ".rokit")) / "bin",
        home / ".aftman" / "bin",
        home / ".foreman" / "bin",
        home / ".local" / "bin",
        home / ".cargo" / "bin",
        Path("/opt/homebrew/bin"),
        Path("/usr/local/bin"),
    ]

    for root in roots:
        for name in executable_names(tool):
            candidate = root / name
            if candidate.is_file() and os.access(candidate, os.X_OK):
                return str(candidate)

    return None


def main() -> int:
    if len(sys.argv) < 2 or sys.argv[1] not in TOOL_NAMES:
        print(f"usage: {Path(sys.argv[0]).name} <stylua|selene> [args...]", file=sys.stderr)
        return 2

    tool = sys.argv[1]
    args = sys.argv[2:]
    executable = find_tool(tool)

    if executable is None:
        print(
            f"{TOOL_NAMES[tool]} not found. Install the project tools with `rokit install`, "
            f"or add `{tool}` to PATH.",
            file=sys.stderr,
        )
        return 1

    try:
        return subprocess.call([executable, *args])
    except OSError as error:
        print(f"Failed to run {tool}: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
