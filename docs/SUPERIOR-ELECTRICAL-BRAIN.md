# Superior Electrical brain pointer

The canonical Superior Electrical client brain lives in **`vaaibstudio-star/superior-electrical`** (`workspaces/superior-electrical/MASTER-BRAIN.md`). It moved out of `vaaib-growth-os` (whose copy is now a pointer). The Social Publisher contract is at `superior-electrical/workspaces/superior-electrical/handoffs/SOCIAL-PUBLISHER-V1.md`.

Superior Electrical is RetailOS's **pilot tenant**: its configuration and pilot evidence belong to the pilot, never hard-coded into product logic.

When building RetailOS or any Superior automation:

1. read the canonical client brain when client truth affects the task;
2. treat this repository's code and configuration as implementation evidence;
3. report conflicts instead of silently reconciling them;
4. never store secrets, tokens or customer data in this repository;
5. no real publishing or live Shopify write occurs without explicit current approval.
