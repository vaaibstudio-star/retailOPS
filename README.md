# RetailOPS

Implementation repository for **RetailOS** (VAAIB retail operations product). Superior Electrical is the pilot tenant. Current status and open decisions: [DISPOSITION.md](DISPOSITION.md).

## Repository purpose

This repository separates the approved Figma Make prototype from the production application:

- `reference/archive/` — immutable encoded Make source export.
- `reference/make-prototype/` — generated locally by the unpack script; never edit.
- `apps/pos-web/` — Cursor builds the production-facing interface here.
- `prompts/` — controlled implementation passes.
- `.cursor/rules/retailos.mdc` — persistent product and engineering rules.
- `docs/` — audits, contracts, decisions and pass reports.

## First setup in Cursor

Clone this repository, then run in PowerShell from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\UNPACK-MAKE-PROTOTYPE.ps1
```

Then open the repository in Cursor and paste:

```text
Read and obey:
1. .cursor/rules/retailos.mdc
2. prompts/01-PASS-1-INTERFACE.md

Execute Pass 1 now. Inspect reference/make-prototype as an immutable visual and interaction reference, and implement only inside apps/pos-web. Do not connect Shopify or start Pass 2.
```

## Build sequence

1. Pass 1 — approved interface and mock workflows.
2. Founder review and correction pass.
3. Pass 2 — production foundation, security, database and offline contracts.
4. Pass 3 — Shopify integration and controlled pilot.

## Critical rule

The Figma Make source is a reference, not trusted production architecture. Do not reuse generated authentication, payment, Shopify, database or security logic without audit.

## Repository visibility

This repository is currently public. Change it to **Private** before adding credentials, production configuration, customer data or any live Shopify integration.
