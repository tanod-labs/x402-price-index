# x402 price index

Daily listed per-call prices of x402 endpoints, taken from the Coinbase CDP x402 Bazaar and PayAI, and collected by Tanod (https://tanod.dev/data/). The repository holds the daily category price files and the daily Bazaar statistics, with their history, as JSON and CSV.

Last updated: 2026-10-09

## Hand-checked category medians

Median listed price per call among other x402 sellers (x402 Bazaar and PayAI, hand-checked snapshots of 2026-10-09 and 2026-10-10), against Tanod's price. Each category link opens a page with the offer counts, tables and method. Tanod prices as of 2026-10-08; the 402 response of each route is authoritative.

| Category | Market median (USD) | Tanod (USD) |
|---|---|---|
| [EVM chain reads](https://tanod.dev/learn/evm-chain-read-api-prices.html) | 0.003 | 0.001 to 0.003 |
| [Solana reads](https://tanod.dev/learn/solana-read-api-prices.html) | 0.005 | 0.002 |
| [PDF tools](https://tanod.dev/learn/pdf-api-prices.html) | 0.010 | mostly 0.005 |
| [OCR](https://tanod.dev/learn/ocr-api-prices.html) | 0.010 | 0.01 |
| [Image processing](https://tanod.dev/learn/image-processing-api-prices.html) | 0.010 | mostly 0.002 |
| [Speech to text](https://tanod.dev/learn/speech-to-text-api-prices.html) | 0.06 | 0.01 |
| [QR codes](https://tanod.dev/learn/qr-barcode-api-prices.html) | 0.0026 | 0.001 |
| [Company data](https://tanod.dev/learn/company-enrichment-api-prices.html) | 0.027 | 0.005 |
| [Domain availability](https://tanod.dev/learn/domain-availability-api.html) | 0.0095 per call | 0.0005 per name, min 0.002 |
| [WHOIS / RDAP lookup](https://tanod.dev/learn/whois-rdap-api-prices.html) | 0.005 | 0.002 |
| [Website screenshots](https://tanod.dev/learn/website-screenshot-api-prices.html) | 0.01 | 0.005 |
| [OFAC / sanctions address screening](https://tanod.dev/learn/ofac-sanctions-screening-api-prices.html) | 0.005 | 0.002 (batch 0.0005 per address) |
| [Geocoding (forward and reverse)](https://tanod.dev/learn/geocoding-api-prices.html) | 0.003 | 0.001 |
| [Currency exchange rates](https://tanod.dev/learn/exchange-rates-api-prices.html) | 0.005 | 0.001 |
| [Weather forecasts](https://tanod.dev/learn/weather-api-prices.html) | 0.0033 | 0.002 |
| [Text embeddings](https://tanod.dev/learn/text-embeddings-api-prices.html) | 0.003 | 0.001 for one text (0.0005 per text, min 0.001) |
| [Public holidays, business days](https://tanod.dev/learn/public-holidays-api-prices.html) | 0.007 | 0.001 |
| [IP address lookup (ASN, network; no geolocation)](https://tanod.dev/learn/ip-lookup-api-prices.html) | 0.005 | 0.001 |
| [Email verification (DNS only)](https://tanod.dev/learn/email-verification-api-prices.html) | 0.0035 | 0.002 |
| [IBAN and EU VAT validation (offline check digits)](https://tanod.dev/learn/iban-vat-validation-api-prices.html) | 0.005 | 0.001 |
| [Web search](https://tanod.dev/learn/web-search-api-prices.html) | 0.01 | 0.012 (above the median) |
| [Web page to Markdown](https://tanod.dev/learn/web-page-to-markdown-api-prices.html) | 0.005 | 0.005 static, 0.01 with JavaScript |

## Files

All files are in `data/`.

- `x402-category-prices.json`: latest daily snapshot by category. Top-level keys: `dataset`, `snapshot_date`, `method_note`, `license`, `citation`, `price_unit` (USD per call, first payment option), `history_csv`, and `categories`. Each item in `categories` has `category`, `title`, `page_url`, `tanod_price_usd`, `tanod_route`, `offers`, `hosts`, `min`, `p25`, `median`, `p75`, `max`.
- `x402-category-prices-history.csv`: one row per category per day. Columns: `date`, `category`, `offers`, `hosts`, `min`, `p25`, `median`, `p75`, `max`, `tanod_price_usd`.
- `x402-bazaar-stats.json`: latest daily statistics of the Coinbase CDP x402 Bazaar discovery list. Keys: `dataset`, `snapshot_date`, `source`, `method_url`, `license`, `citation`, `history_csv`, `total` (listings), `hosts`, `top_hosts` ([host, listings]), `top10_share_pct`, `single_listing_hosts`, `networks` and `network_combinations` ([name, listings]), `priced` (listings with a price), `price` (min, q1, median, q3, p90, max and shares under 0.001, under 0.01, over 1, zero), `price_buckets`, `metadata_quality` (listings with a use-when hint, over 500 characters, empty, output schema present), `templated_bulk_hosts` (hosts with many near-identical listings and their share), `churn` (listings added, removed and kept between snapshot days), `snapshots` ([date, listings]), `snapshot_days`.
- `x402-bazaar-stats-history.csv`: one row per day. Columns: `date`, `listings`, `hosts`, `median_price_usd`, `use_when_pct`, `over_500`, `empty`, `bulk_host_share_pct`, `added`, `removed`.

## Method and limits

- Prices are listed prices per call, as shown in each endpoint's x402 listing (first payment option). They are not prices that buyers paid.
- The daily files in `data/` use automatic keyword matching over offers last seen in the 3 days up to the snapshot, priced above zero, distinct URLs, with listing farms and Tanod's own hosts excluded. They have no hand review, so counts and quartiles differ from the hand-checked table above.
- The table above comes from hand-checked pages, with snapshots dated 2026-10-09 and 2026-10-10. It does not change with the daily files.
- The history files contain only days on which a snapshot ran. Counts depend on what the sources listed that day.
- Listings can be duplicated, stale or wrongly priced by their sellers. Prices of different services in one category are not always like for like.

## License

CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/). Attribution: Tanod (tanod.dev).

## Updates

The data files are refreshed daily by `update.sh`, which copies the new files from Tanod's site data and commits only when they changed.
