# ADR-001: Multi-architecture repository

## Status

Accepted

## Decision

Use one repository containing an independent Xcode project for each architecture. A root workspace may be created locally for convenience but is excluded from version control. Create each project only when its development stage begins.

Production networking, models, persistence, navigation, UI, assets, and tests remain independent initially. Requirements, feature-parity tracking, fixtures, and documentation may be shared.

## Consequences

Implementations can be inspected and executed side by side without target-membership coupling. Some deliberate duplication is accepted to preserve a meaningful comparison.
