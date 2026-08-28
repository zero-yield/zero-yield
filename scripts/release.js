import { mkdir, copyFile } from "node:fs/promises";
import { execFile } from "node:child_process";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);

await mkdir("dist", { recursive: true });

await copyFile("source", "dist/source.luau");

await execFileAsync("darklua", [
  "process",
  "dist/source.luau",
  "dist/source.min.luau",
]);

console.log("Release build generated.");
