# git-explain-demo

Companion demo repository for `git-explain`.

This demo validates an AI-enabling workflow improvement for practical line-intent recovery, not AI-everything replacement of git history tooling.

This repo is intentionally small but has meaningful line history in `src/order_service.ts`:

1. baseline order state transitions
2. bounded exponential retry loop
3. idempotency enforcement for safe charge reattempts

## Run

```bash
./scripts/run-demo.sh
```

Optional line target:

```bash
./scripts/run-demo.sh 31
```

## What it demonstrates

- Left: raw line-level authorship from `git blame`
- Right: likely intent reconstruction from bounded local context

No cloud APIs and no external issue tracker data are used.

## Canonical assertions

`scripts/test.sh` enforces key output invariants for the baseline line (`31`):

- blamed commit is `e0d8e71d30edab777f15fa19ba242c8dc449d25e`
- summary contains idempotency retry intent
- output includes bounded "Why This Exists (likely)" section


## Test

```bash
./scripts/test.sh
```
