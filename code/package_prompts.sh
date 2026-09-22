#!/usr/bin/env bash
# Build the password-protected archive of the GUISE prompt set.
#
# The plaintext CSVs in data/prompts/ are gitignored and never committed; this
# archive is what the repository distributes. Run from anywhere:
#
#     ./code/package_prompts.sh
#
# zip prompts for the password twice. Extract with:
#
#     unzip data/guise_prompts.zip      # restores data/prompts/*.csv
#
# Note: `zip -e` uses legacy ZipCrypto. It gates the data against casual
# scraping and automated crawlers; it is not strong encryption. Do not rely on
# it to protect anything whose disclosure would be harmful on its own.
set -euo pipefail

cd "$(dirname "$0")/.."

out="data/guise_prompts.zip"
shopt -s nullglob
csvs=(data/prompts/*.csv)
if [ ${#csvs[@]} -eq 0 ]; then
  echo "error: no CSVs found in data/prompts/" >&2
  exit 1
fi

rm -f "$out"
zip -e "$out" "${csvs[@]}"

echo
echo "Wrote $out"
unzip -l "$out"
