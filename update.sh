#!/bin/sh
# Download published snapshots for local review; never commit or publish them.
set -eu
cd "$(dirname "$0")"
stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT HUP INT TERM
for f in x402-category-prices.json x402-category-prices-history.csv x402-bazaar-stats.json x402-bazaar-stats-history.csv x402-prices.md; do
  curl --fail --silent --show-error --max-time 60 "https://tanod.dev/data/$f" -o "$stage/$f"
done
python3 -I - "$stage" <<'PY'
import csv
import json
import sys
from pathlib import Path
root = Path(sys.argv[1])
for name in ("x402-category-prices", "x402-bazaar-stats"):
    snapshot = json.loads((root / (name + ".json")).read_text())
    assert snapshot["snapshot_date"], "missing snapshot date"
    if name == "x402-category-prices":
        snapshot["method_note"] = (
            "Automatic keyword matches over the agent-index offers last seen in the 3 days up to the snapshot, "
            "priced above zero, distinct URLs, listing farms and Tanod's own hosts excluded. "
            "No hand review, so counts and quartiles differ from the hand-curated price pages, "
            "which stay the reference. Tanod prices come from https://tanod.dev/openapi.json.")
        (root / (name + ".json")).write_text(json.dumps(snapshot, indent=1) + "\n")
    with (root / (name + "-history.csv")).open() as stream:
        assert len(list(csv.reader(stream))) > 1, "empty history"
PY
mkdir -p data
for f in "$stage"/*; do
  cp "$f" "data/$(basename "$f")"
done
printf '%s\n' 'Downloaded published data. Review the diff and snapshot dates before committing.'
