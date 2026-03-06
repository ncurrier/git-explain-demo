# git-explain-demo

Companion demo repository for `git-explain`.

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


## Test

```bash
./scripts/test.sh
```
