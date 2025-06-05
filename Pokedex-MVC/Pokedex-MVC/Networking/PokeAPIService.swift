//  PokeAPIService.swift
//  Pokedex-MVC
//  Created by Daniel Garcia on 04/06/25.

import Foundation

class PokeAPIService {
  static let shared = PokeAPIService()
  private let baseURL = "https://pokeapi.co/api/v2/"
  
  private init() {}

  // MARK: - Pokémon List
  func fetchPokemonList(limit: Int = 20, offset: Int = 0, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
    let urlString = "\(baseURL)pokemon?limit=\(limit)&offset=\(offset)"
    guard let url = URL(string: urlString) else {
      return completion(.failure(makeURLError()))
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        return completion(.failure(error))
      }
      guard let data = data else {
        return completion(.failure(self.makeNoDataError()))
      }
      do {
        let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        completion(.success(decoded.results))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }

  // MARK: - Pokémon Detail
  func fetchPokemonDetail(name: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
    let urlString = "\(baseURL)pokemon/\(name)"
    guard let url = URL(string: urlString) else {
      return completion(.failure(makeURLError()))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        return completion(.failure(error))
      }
      guard let data = data else {
        return completion(.failure(self.makeNoDataError()))
      }
      do {
        let decoded = try JSONDecoder().decode(PokemonDetail.self, from: data)
        completion(.success(decoded))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }

  // MARK: - Pokémon Species → Evolution Chain URL
  func fetchPokemonSpecies(name: String, completion: @escaping (Result<String, Error>) -> Void) {
    let urlString = "\(baseURL)pokemon-species/\(name)"
    guard let url = URL(string: urlString) else {
      return completion(.failure(makeURLError()))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        return completion(.failure(error))
      }
      guard let data = data else {
        return completion(.failure(self.makeNoDataError()))
      }
      do {
        let species = try JSONDecoder().decode(PokemonSpecies.self, from: data)
        completion(.success(species.evolution_chain.url))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }

  // MARK: - Evolution Chain
  func fetchEvolutionChain(from urlString: String, completion: @escaping (Result<[String], Error>) -> Void) {
    guard let url = URL(string: urlString) else {
      return completion(.failure(makeURLError()))
    }

    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        return completion(.failure(error))
      }
      guard let data = data else {
        return completion(.failure(self.makeNoDataError()))
      }
      do {
        let evolution = try JSONDecoder().decode(EvolutionChainResponse.self, from: data)
        let names = self.parseEvolutionChain(evolution.chain)
        completion(.success(names))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }

  // MARK: - Helpers
  private func parseEvolutionChain(_ step: EvolutionStep) -> [String] {
    var result = [step.species.name]
    for next in step.evolves_to {
      result.append(contentsOf: parseEvolutionChain(next))
    }
    return result
  }

  private func makeURLError() -> Error {
    return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
  }

  private func makeNoDataError() -> Error {
    return NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
  }
}
