# .config

**Doc type**: entry doc.
**Reader**: me on a new Mac, or an agent working in this repo cold.
**Question it answers**: what lives here, where it is linked from, and how to install it.

## Directory map

| Path             | Holds                                                     |
| ---------------- | --------------------------------------------------------- |
| `config/<tool>/` | one directory per tool: nvim, zsh, yazi, lazygit, ghostty |
| `claude/`        | the Claude Code user config for this laptop               |
| `.claude/`       | this repo's own project instructions for Claude Code      |
| `Brewfile`       | Homebrew packages, `brew bundle` installs them            |

The Claude package lives at `claude/`, never at `.claude/`. Claude Code reads `.claude/` as the
project config of whatever repo it runs in, so a user config placed there would load twice.

## Symlinks

Hand-made, no stow, no Makefile. Source is this repo, target is the live path.

| Repo                           | Live path                                     |
| ------------------------------ | --------------------------------------------- |
| `config/zsh/.zshrc`            | `~/.zshrc`                                    |
| `config/zsh/zsh`               | `~/.config/zsh`                               |
| `config/nvim`                  | `~/.config/nvim`                              |
| `config/yazi`                  | `~/.config/yazi`                              |
| `config/lazygit`               | `~/.config/lazygit`                           |
| `claude/CLAUDE.md`             | `~/.claude/CLAUDE.md`                         |
| `claude/settings.json`         | `~/.claude/settings.json`                     |
| `claude/statusline-command.sh` | `~/.claude/statusline-command.sh`             |
| `claude/skills/<name>`         | `~/.claude/skills/<name>`, one link per skill |

- `~/.claude` itself is never linked. It also holds Claude Code's runtime state, which stays
  out of git.
- `~/.claude/skills/` also holds links into the private repo, see below.
- `~/.zshrc.local` is sourced by `.zshrc` and holds tokens. It is never tracked.

## Claude config

`claude/` is the home-laptop set: `CLAUDE.md`, `settings.json`, the statusline script, the
plugin manifests under `plugins/`, and one real directory per skill under `skills/`.

The work laptop's `~/.claude/CLAUDE.md` is a two-line import file, `@…/claude/CLAUDE.md`
then `@…/claude/CLAUDE.work.md`, and it keeps its own `settings.json`. Imports resolve on
Claude Code 2.1.x; the file never needs regenerating after a pull. A rule is in `CLAUDE.work.md` only while it is wrong for home. Reason: a
rule inside the shared file is read on both machines even when marked "work only".

Skills that carry personal or work content live in the private repo
[claude-private](https://github.com/shirohana/claude-private) and are linked the same way,
one link per skill into `~/.claude/skills/`. That repo also tracks `~/.claude/english`, the data
the english-coach skill writes. The two gists that used to carry this config are retired and
point here.

## New machine

1. Clone this repo and run `brew bundle`. Home keeps it at `~/Repositories/@shirohana/.config`,
   work at `~/@shirohana/.config`; the private repo sits beside it either way.
2. Create every link in the Symlinks table with `ln -s <repo path> <live path>`.
3. Clone claude-private and link each of its skills and its `english/` directory into
   `~/.claude`.
4. Link `~/.claude/skills/save/bin/saves` to `/usr/local/bin/saves` so the `saves` command
   works.
5. Start `claude` once. The session-start banner lists saved handoffs when the save hook is
   wired.

## Also see

- [.claude/HANDOFF.md](./.claude/HANDOFF.md): open cleanup work in this repo, phases and
  decisions.
