# RetailOS — agent map

**VAAIB-managed product repo.** Runtime and capabilities come from `vaaib-growth-os` (Skills named `vaaib-*`). Open this repo together with `../vaaib-growth-os`. Runtime check before material work: `python3 ../vaaib-growth-os/scripts/vaaib.py doctor --client .` (Windows: `py -3`).

- Product rules: `.cursor/rules/retailos.mdc` (V1 scope, money in ZAR integer cents, VAT-inclusive 15%, tenths of a metre, no plaintext PINs, sale recorded locally before Shopify).
- Status and open decisions: `DISPOSITION.md` (repo is public; locked contracts are held until it is private).
- Superior Electrical (pilot tenant) truth: `docs/SUPERIOR-ELECTRICAL-BRAIN.md` points to the canonical client repo.
- Typical leads: Steve (`vaaib-product-ux`) for staff flows, Visual Design for the UI look, Willem (`vaaib-engineering`) for code, Edna (`vaaib-verification`) for checks. The founder releases.
