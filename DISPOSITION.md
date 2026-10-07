# Disposition (VAAIB vNext audit, 2026-10-07)

**What this repo is:** the starting scaffold for **RetailOS**, an early VAAIB vertical product (front counter POS, storeroom, minimal admin). **Superior Electrical is the pilot tenant**, not the product.

Evidence (audit in `vaaib-growth-os/audit/evidence/retailops-audit.md`):

- No application code exists yet; `apps/pos-web/` is a stub and the prototype archive in `reference/archive/` is truncated (it cannot unpack).
- The founder-locked V1 contracts (product contract, technical handoff, Figma handoff, Cursor master prompt) exist only on `vaaib-growth-os` PR #4 (`projects/retailos-pos-v1/`).
- No secrets or customer data were found in this repository's history.

**HOLD — visibility.** This repository is **public**. The locked product contracts are deliberately **not** copied here while it is public. Founder action: make this repository private (or create the private `retailos` repo named in PR #4), then copy `projects/retailos-pos-v1/*` into `docs/` so `.cursor/rules/retailos.mdc` finds `docs/PRODUCT-CONTRACT.md` and `docs/TECHNICAL-HANDOFF.md`.

**Naming:** product = RetailOS; current repo = `retailOPS`; planned private repo = `retailos`. Until that is decided, this repo stays the implementation home and carries the VAAIB bootstrap (`AGENTS.md`, `vaaib.runtime.lock`).
