You are Willem, the senior product engineer responsible for converting the downloaded Figma Make prototype into the approved RetailOps V1 interface.

Work only inside `apps/pos-web`.
Treat `reference/make-prototype` as immutable evidence and visual reference.

## Goal of this pass
Create a clean, fully navigable, mock-data RetailOps interface that matches the approved staff workflows. Do not connect Shopify, create a real backend, implement real authentication, access printers or call external payment services in this pass.

## Start with an audit
Before modifying files, inspect:
- `apps/pos-web/src/app/App.tsx`
- all files in `apps/pos-web/src/app/components`
- `apps/pos-web/src/app/lib/calculations.ts`
- `apps/pos-web/src/styles`
- `apps/pos-web/package.json`
- `.cursor/rules/retailos.mdc`

Record a concise audit in `docs/PASS-1-AUDIT.md`.

The downloaded prototype currently has known defects that must be corrected:
- it is a single `Screen` state switch rather than route-based structure;
- login routes staff to a dashboard;
- it includes dashboard, reports, commission and manager-dashboard bloat;
- `PaymentMethod` includes EFT;
- employee PINs are hard-coded in plaintext;
- products and employees are hard-coded in `App.tsx`;
- F12 locks the register instead of opening payment;
- the displayed product amounts are not modelled as ZAR integer cents;
- `calculateCartTotals` adds 15% tax on top even though RetailOps prices are VAT-inclusive;
- no storeroom queue or picking workflow exists;
- the Make guidelines file is effectively empty;
- the UI shows unverified states such as “Shopify Synced”.

## Required architecture for this pass
Refactor the front end into:

```text
src/
  app/
    App.tsx
    router.tsx
    layouts/
      FrontCounterLayout.tsx
      StoreroomLayout.tsx
      AdminLayout.tsx
    routes/
      front-counter/
      storeroom/
      admin/
    components/
      shared/
      retailops/
    domain/
      money.ts
      quantity.ts
      product.ts
      cart.ts
      sale.ts
      payment.ts
      fulfilment.ts
      employee.ts
    services/
      contracts.ts
      mock/
    state/
      retailOpsStore.ts
    data/
      mockProducts.ts
      mockEmployees.ts
    lib/
  styles/
```

Use React Router already present in the package unless the installed version makes that impossible. Do not introduce Next.js or a separate framework in this pass.

## Required routes

Front counter:
- `/login`
- `/open-register`
- `/sale`
- `/sale/payment`
- `/sale/payment/card`
- `/sale/payment/cash`
- `/sale/payment/account`
- `/sale/payment/split`
- `/sale/complete`
- `/recent-sales`
- `/recent-sales/:saleId`
- `/recent-sales/:saleId/fix`
- `/recent-sales/:saleId/return`
- `/cash-up`
- `/cash-up/count`
- `/cash-up/review`
- `/cash-up/complete`
- `/lock`

Storeroom:
- `/storeroom/login`
- `/storeroom/to-pick`
- `/storeroom/scan-order`
- `/storeroom/order/:orderId`
- `/storeroom/order/:orderId/problem`
- `/storeroom/order/:orderId/ready`
- `/storeroom/ready`
- `/storeroom/history`
- `/storeroom/lock`

Minimal admin:
- `/admin/shopify`
- `/admin/staff`
- `/admin/roles`
- `/admin/registers`
- `/admin/devices`
- `/admin/printers`
- `/admin/commission`
- `/admin/customer-accounts`
- `/admin/receipt`
- `/admin/cash-up`
- `/admin/orders-attention`

## Domain rules

### Money
Use integer cents.

```ts
export type Cents = number & { readonly __brand: "Cents" };
```

All mock product prices and calculated totals must be cents. Format using `Intl.NumberFormat("en-ZA", { style: "currency", currency: "ZAR" })`.

Prices are VAT-inclusive. Derive the VAT portion from the inclusive total. Do not add 15% to the displayed price.

### Measured quantity
Use integer tenths of a metre.

```ts
export type TenthsOfMetre = number & { readonly __brand: "TenthsOfMetre" };
```

`12.5 m` is stored as `125` tenths.

### Payment
Supported mock payment methods:
- card;
- cash;
- customer account;
- split card and cash.

No EFT.

Card copy must include:
- `Use the card machine.`
- `Check that the card machine shows Approved.`
- primary button: `Terminal shows Approved`

### Order completion
When a mock payment is confirmed:
1. record the sale in local app state;
2. create a mock fulfilment job immediately;
3. show `Sale complete`;
4. show `Sent to storeroom`;
5. show Shopify as `Waiting to update Shopify` under More details.

Never show Shopify synced by default.

## Staff interface requirements

Front-counter navigation only:
- New sale
- Recent sales
- Cash-up
- Lock register

Storeroom navigation only:
- To pick
- Picking
- Ready
- Lock

Ordinary staff must never land on a dashboard.

New Sale must keep product discovery and Current sale visible together. Product images, names, variants, prices and stock take priority over SKU metadata.

Use the exact approved language already supplied in the project conversation, including:
- Scan the item
- The item will be added automatically.
- Scan barcode or type a product name
- Take payment
- Save for later
- Sale complete
- Sent to storeroom
- Start next sale
- Orders to pick
- Start with the first order.
- Start picking
- Scan this item
- Correct item
- Measure the cable
- Can’t pick this item
- Given to customer

## Reuse versus removal
Reuse clean presentational primitives and useful UI files.
Retire or remove ordinary-user access to:
- Dashboard.tsx
- ReportsScreen.tsx
- ManagerDashboardScreen.tsx
- CommissionScreen.tsx
- ActivityLogScreen.tsx
- dashboard-first TopNav structure

Do not delete potentially useful code until its replacement works. Put obsolete files in `src/legacy/` during this pass if that is safer.

## Required mock scenarios
Implement navigable mock states for:
- successful card sale;
- cash and change;
- customer account allowed and insufficient balance;
- split card and cash;
- unfinished sale restored;
- offline selling;
- cached stock warning;
- printer failure with order still received by storeroom;
- Shopify update pending;
- wrong item scanned;
- measured cable pick;
- short pick sent to front counter;
- order paused for correction;
- revised order version 2;
- order ready and given to customer;
- cash-up with no difference and with a discrepancy.

## Tests
Add tests for:
- VAT-inclusive money calculations;
- integer-cent line totals;
- measured quantity calculations;
- cash change;
- split-payment equality;
- sale completion creating exactly one fulfilment job;
- correction creating version 2 while preserving version 1;
- Shopify-pending state not changing payment state.

## Completion gate
Run install/build/tests. Fix all failures.

Create `docs/PASS-1-REPORT.md` containing only:
- routes created;
- components reused;
- components created;
- files retired;
- mock states implemented;
- tests run and results;
- remaining blockers.

Do not connect Shopify.
Do not create a production database.
Do not implement real PIN authentication.
Do not change the approved copy or add scope.
Stop after the mock interface passes build and tests.
