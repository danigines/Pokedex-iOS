//  PokeAPIService.swift
//  Pokedex-MVC
//  Created by Daniel Garcia on 04/06/25.

import Foundation

class PokeAPIService {
  static let shared = PokeAPIService()
  private let baseURL = "https://pokeapi.co/api/v2/"
  
  private init() {}
  
  func fetchPokemonList(limit: Int = 20, offset: Int = 0, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
    let urlString = "\(baseURL)pokemon?limit=\(limit)&offset=\(offset)"
    guard let url = URL(string: urlString) else {
      return completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        return completion(.failure(error))
      }
      guard let data = data else {
        return completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
      }
      do {
        let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        completion(.success(decoded.results))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}
