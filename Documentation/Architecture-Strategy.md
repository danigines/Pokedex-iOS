# Architecture Strategy

The repository uses a monorepo with one independent Xcode project per architecture. A local root workspace may be used for convenience, but it is not versioned.

## Shared

- Product requirements and roadmap
- Feature-parity tracking
- Architecture decisions and comparisons
- Test fixtures and approved visual references when introduced
- Repository-level tooling and conventions

## Independent

Each application owns its production networking, models, persistence, navigation, UI, assets, and tests. Production modules are not shared initially so architectural responsibilities remain visible and comparable.

Only MVC exists now. MVP, MVVM, and VIPER will be created when their development stages begin.
