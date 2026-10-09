#!/bin/sh
# Copy the daily data files, refresh the "Last updated" line, commit and push only if data changed.
set -eu
cd "$(dirname "$0")"
SRC=/root/venture/site/data
for f in x402-category-prices.json x402-category-prices-history.csv x402-bazaar-stats.json x402-bazaar-stats-history.csv; do
  cp "$SRC/$f" "data/$f"
done
if [ -z "$(git status --porcelain data)" ]; then
  echo "no data change"
  exit 0
fi
today=$(date -u +%F)
sed "s/^Last updated: .*/Last updated: $today/" README.md > README.md.tmp && mv README.md.tmp README.md
git -c user.name=Tanod -c user.email=ops@tanod.dev commit -m "data: $(date -u +%F)" -- data README.md && git push
