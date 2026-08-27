import fs from "fs";
const version = process.argv[2];

if (!version) {
  console.error("Usage: node update-version.js <version>");
  process.exit(1);
}

const file = "version";
const data = JSON.parse(fs.readFileSync(file, "utf8"));
data.Version = version;
// Change the version in the version file
fs.writeFileSync(file, JSON.stringify(data, null, "\t") + "\n");

// Change the version in the source code
const sourceFile = "src/core/services.luau";
let sourceData = fs.readFileSync(sourceFile, "utf8");
sourceData = sourceData.replace(
  /currentVersion = "[^"]*"/,
  `currentVersion = "${version}"`,
);
fs.writeFileSync(sourceFile, sourceData);

console.log(`Version updated to ${version}`);
