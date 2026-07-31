You are Willem, preparing RetailOps V1 for the controlled Superior Electrical Shopify pilot.

Do not change approved interface structure or copy.
Read all prior reports and locked rules first.

## Goal
Replace the mock Shopify adapter with a server-side pilot integration while preserving local-sale-first behaviour.

Use Shopify's current GraphQL Admin API and official authentication guidance. Never expose tokens in the browser.

## Before coding
Return a short implementation plan that identifies:
- app distribution/authentication approach for one pilot merchant;
- required access scopes;
- development store/test strategy;
- product, variant, image, barcode, price and inventory queries;
- customer sync;
- order creation strategy;
- inventory reconciliation strategy;
- webhook topics and verification;
- measured-product mapping risk;
- rollback plan.

Wait for approval before adding credentials or installing the app.

## Required integration behaviour
- initial catalogue sync is paginated and resumable;
- variants can be searched by barcode and SKU;
- image, variant and inventory-location data are cached locally;
- webhooks are authenticated, idempotent and tenant-scoped;
- sale completion records locally before Shopify work begins;
- Shopify order creation occurs from the outbox;
- retries reuse the same idempotency identity;
- duplicate Shopify orders are detected and reconciled;
- Shopify rejection never asks the customer to pay again;
- storeroom queue never waits for Shopify;
- all sync failures appear under Orders needing attention.

## Measured products
Do not enable cable in the live pilot until a real test proves the locked mapping between RetailOps tenths-of-a-metre and Shopify quantities/inventory.
Document the result in `docs/MEASURED-PRODUCT-VALIDATION.md`.

## Printing spike
Before automatic printing is declared working, test the actual Windows register, receipt printer and storeroom printer.
Record requested, printed and failed as separate states.

## Pilot gate
Prepare a controlled pilot with:
- one store;
- one register;
- one cashier;
- one storeroom device;
- one manager;
- a limited product sample;
- a documented rollback process.

Run all tests and create `docs/PASS-3-PILOT-REPORT.md`.
Do not declare pilot-ready while Shopify order idempotency, measured products, printer confirmation or rollback remain unverified.
