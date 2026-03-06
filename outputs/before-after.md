# Before / After Output Plan

Target line for demonstration:

- `src/order_service.ts:31`

Before:

- raw `git blame` output with commit hash + author + timestamp

After:

- `git-explain` output with:
  - blamed commit metadata
  - bounded local context
  - plain-English explanation of likely intent

Capture command:

```bash
./scripts/run-demo.sh 31 > outputs/demo.runtime.txt
```
