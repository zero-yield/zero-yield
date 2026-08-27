import { mkdir } from "node:fs/promises";
import { execFile } from "node:child_process";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);

await mkdir("dist", { recursive: true });

// Bundle modules into a single file (unminified)
await execFileAsync("darklua", [
  "process",
  "src/init.luau",
  "dist/source.luau",
]);

// Bundle + minify
await execFileAsync("darklua", [
  "process",
  "src/init.luau",
  "dist/source.min.luau",
]);

console.log("Release build generated.");
