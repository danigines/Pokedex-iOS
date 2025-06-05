# 📱 Pokedex-MVC

An iOS application built with Swift using **UIKit** and the **MVC (Model-View-Controller)** architecture. This app consumes the [PokéAPI](https://pokeapi.co/) to display a list of Pokémon and their details.

## 🧱 Architecture

This project follows the **MVC** design pattern, commonly used for small to mid-sized iOS apps:

- **Model**: Data structures representing Pokémon, abilities, types, etc.
- **View**: Storyboards and UIKit components to display the interface.
- **Controller**: `UIViewController` handles UI logic, navigation, and data fetching.

## 🚀 Features

- Paginated Pokémon list.
- Pokémon detail screen with:
  - Image
  - Types
  - Abilities
  - (Coming soon) Stats
- Data fetched from the PokéAPI.

## 📦 Dependencies

This project has **no external dependencies**. Networking is implemented using `URLSession` and native Swift APIs.

## 🏗️ Project Structure
```
PokedexMVC/
├── Controllers/
├── Models/
├── Networking/
├── Views/
├── Resources/
```
