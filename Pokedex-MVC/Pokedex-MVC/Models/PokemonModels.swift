//  PokemonModels.swift
//  Pokedex-MVC
//  Created by Daniel Garcia on 04/06/25.

import Foundation

struct PokemonListResponse: Decodable {
  let results: [Pokemon]
}

struct Pokemon: Decodable {
  let name: String
  let url: String
}

struct PokemonDetail: Decodable {
  let id: Int
  let name: String
  let sprites: Sprites
  let abilities: [AbilitySlot]
  let types: [TypeSlot]
  let stats: [Stat]
}

struct Sprites: Decodable {
  let front_default: String?
}

struct AbilitySlot: Decodable {
  let ability: Ability
}

struct Ability: Decodable {
  let name: String
}

struct TypeSlot: Decodable {
  let type: PokemonType
}

struct PokemonType: Decodable {
  let name: String
}

struct Stat: Decodable {
  let base_stat: Int
  let stat: StatInfo
}

struct StatInfo: Decodable {
  let name: String
}
