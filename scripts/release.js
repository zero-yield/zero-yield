import { mkdir } from "node:fs/promises";
import { execFile } from "node:child_process";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);

await mkdir("dist", { recursive: true });

// Bundle modules into a single file (readable, unminified)
await execFileAsync("darklua", [
  "process",
  "src/init.luau",
  "dist/source.luau",
]);

// Bundle + minify (dense format with minification rules)
await execFileAsync("darklua", [
  "process",
  "-c", ".darklua.min.json5",
  "--format", "dense",
  "src/init.luau",
  "dist/source.min.luau",
]);

console.log("Release build generated.");
