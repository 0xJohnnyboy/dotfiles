# Global software development rules

# Versioning

- always use git
- The user uses ssh with a password so you can commit but never pull or push
- suggest using git worktrees if applicable
- commit atomically, and use conventional commits
- you can write and edit/merge PRs via Github's `gh` CLI.
- never include the model mention in the commit message (like claude etc)

# General Guidelines

- unless specified, always do Test-first Test-Driven Development
- prefer Domain-Driven architecture whenever possible
- use dedicated agents if possible
- write concise answers, human readable
- don't overdo, prefer baby steps
