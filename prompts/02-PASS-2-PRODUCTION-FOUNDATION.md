You are Willem, the senior product engineer productionising the approved RetailOps V1 mock interface.

Read first:
- `.cursor/rules/retailos.mdc`
- `docs/PASS-1-AUDIT.md`
- `docs/PASS-1-REPORT.md`
- all domain and service-contract files created in Pass 1.

Do not redesign the interface.
Do not connect a live Shopify store in this pass.

## Goal
Create a secure production foundation behind the approved interface using local development services and mock Shopify adapters.

## Create

```text
apps/
  pos-web/
  server/
packages/
  domain/
  database/
  shopify/
  printing/
  shared/
```

Keep the existing front-end appearance and routes.

## Server responsibilities
- employee identity and hashed PIN verification;
- tenant, store, register and device context;
- register sessions;
- sales and sale lines;
- payment records;
- fulfilment jobs and pick lines;
- corrections and order versions;
- cash-up;
- audit records;
- sync outbox and retry state;
- printer jobs and result state.

## Required technical contracts
- TypeScript strict mode.
- Zod validation at every server boundary.
- PostgreSQL-compatible schema and migrations.
- SQLite may be used for local automated tests only.
- PINs salted and hashed; never readable after storage.
- Money stored as integer cents.
- Measured quantity stored as integer tenths.
- Immutable completed sale and cash-up records.
- Corrections append a new version; they do not overwrite the original sale.
- Transactional outbox for Shopify work.
- Idempotency key for every external order attempt.
- Audit every payment confirmation, refund, correction, approval and register closure.

## Service interfaces
Implement server-side interfaces and mock adapters for:
- CatalogueService
- InventoryService
- CustomerService
- SaleService
- PaymentRecordService
- FulfilmentService
- PrinterService
- ShopifySyncService

No presentation component may call Shopify or the database directly.

## API
Create typed endpoints used by the existing UI for:
- login and register session;
- product search by barcode, SKU and text;
- customer search and account status;
- draft basket persistence;
- sale completion;
- fulfilment queue;
- pick confirmation and pick problems;
- order ready and handover;
- corrections and revised versions;
- cash-up;
- admin setup and orders needing attention.

## Offline preparation
Add a client-side persistence boundary and queue contract, but keep the network adapter local/mock in this pass.
The UI must be able to restore an unfinished sale and show queued actions without claiming they reached Shopify.

## Tests
Add integration tests proving:
- a paid sale is recorded once;
- one fulfilment job is created once;
- duplicate sale-completion requests do not duplicate orders;
- Shopify failure does not undo payment;
- a correction creates version 2 and pauses version 1;
- cash-up becomes immutable after closure;
- employee PIN hashes are never returned to the client;
- tenant boundaries are enforced.

Run build, typecheck, lint, unit and integration tests.

Create `docs/PASS-2-REPORT.md` with:
- architecture created;
- database tables and migrations;
- endpoints created;
- security controls;
- tests and results;
- remaining Shopify, printing and pilot blockers.

Stop before live Shopify credentials, webhooks or printer setup.
