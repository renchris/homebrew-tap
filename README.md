# homebrew-tap

Homebrew tap for [`worktree-harness`](https://github.com/renchris/worktree-harness) —
run parallel coding-agent sessions in isolated git worktrees, with safe
fast-forward-only merge-back.

## Install

```sh
brew install renchris/tap/worktree-harness
```

or:

```sh
brew tap renchris/tap
brew install worktree-harness
```

Then:

```sh
worktree-harness init      # scaffold a .harnessrc in your repo
worktree-harness new feat  # runnable, isolated worktree
```

See the [main repo](https://github.com/renchris/worktree-harness) for docs.
