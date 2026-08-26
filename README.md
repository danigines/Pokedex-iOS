# Pokédex iOS — Architecture Study

An educational UIKit project implementing the same Pokédex with MVC, MVP, MVVM, and VIPER to compare responsibilities, dependencies, navigation, and testability.

## Status

| Architecture | Status |
| --- | --- |
| MVC | Ready for implementation |
| MVP | Not started |
| MVVM | Not started |
| VIPER | Not started |

Only MVC exists today. Each architecture will have an independent Xcode project inside `Applications/`.

## Open the project

1. Open `Applications/MVC/PokedexMVC.xcodeproj` in Xcode.
2. Select the `PokedexMVC` scheme.
3. Choose an iOS simulator and run the application.

The current application is intentionally an empty UIKit baseline.

## Technical baseline

- Swift 6
- UIKit with programmatic screens
- iOS 16 or later
- iPhone only
- Portrait orientation
- No external dependencies

## Documentation

- [Architecture strategy](Documentation/Architecture-Strategy.md)
- [Feature parity](Documentation/Feature-Parity.md)
- [Roadmap](Documentation/Roadmap.md)
- [Functional overview](Documentation/Requirements/Functional-Overview.md)
- [Architecture decision](Documentation/Decisions/ADR-001-Multi-Architecture-Repository.md)

## Data source

Future versions will use [PokéAPI](https://pokeapi.co/). This project is not affiliated with or endorsed by The Pokémon Company, Nintendo, Game Freak, or Creatures.

## Author

Daniel Garcia

## License

Copyright © 2026 Daniel Garcia. All rights reserved. See [LICENSE](LICENSE).
