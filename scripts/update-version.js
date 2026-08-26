// This file is used for Semantic Release to bump automatically Zero Yield's version.

import fs from "fs";
const version = process.argv[2];

if (!version) {
  console.error('Usage: node update-version.js <version>');
  process.exit(1);
}

const file = 'version';
const data = JSON.parse(fs.readFileSync(file, 'utf8'));
data.Version = version;
fs.writeFileSync(file, JSON.stringify(data, null, '\t') + '\n');
console.log(`Version updated to ${version}`);
