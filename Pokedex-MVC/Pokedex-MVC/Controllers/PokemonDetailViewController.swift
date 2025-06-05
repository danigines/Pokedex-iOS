//  PokemonDetailViewController.swift
//  Pokedex-MVC
//  Created by Daniel Garcia on 04/06/25.

import UIKit

class PokemonDetailViewController: UIViewController {
  var pokemon: Pokemon!
  var pokemonDetail: PokemonDetail?

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var typesLabel: UILabel!
  @IBOutlet weak var abilitiesLabel: UILabel!
  @IBOutlet weak var statsLabel: UILabel!
  @IBOutlet weak var evolutionLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    title = pokemon.name.capitalized
    fetchPokemonDetail()
  }

  private func fetchPokemonDetail() {
    PokeAPIService.shared.fetchPokemonDetail(name: pokemon.name) { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let detail):
          self?.pokemonDetail = detail
          self?.updateUI()
          self?.fetchEvolutionChain(for: detail.name)
        case .failure(let error):
          print("Error: \(error)")
        }
      }
    }
  }

  private func fetchEvolutionChain(for name: String) {
    PokeAPIService.shared.fetchPokemonSpecies(name: name) { [weak self] result in
      switch result {
      case .success(let evoURL):
        PokeAPIService.shared.fetchEvolutionChain(from: evoURL) { chainResult in
          DispatchQueue.main.async {
            switch chainResult {
            case .success(let names):
              self?.evolutionLabel.text = "Evolution Chain: " + names.joined(separator: " → ").capitalized
            case .failure(let error):
              self?.evolutionLabel.text = "No evolution data"
              print("Evolution error: \(error)")
            }
          }
        }
      case .failure(let error):
        DispatchQueue.main.async {
          self?.evolutionLabel.text = "No species data"
          print("Species error: \(error)")
        }
      }
    }
  }

  private func updateUI() {
    guard let detail = pokemonDetail else { return }
    nameLabel.text = detail.name.capitalized
    typesLabel.text = "Types: " + detail.types.map { $0.type.name.capitalized }.joined(separator: ", ")
    abilitiesLabel.text = "Abilities: " + detail.abilities.map { $0.ability.name.capitalized }.joined(separator: ", ")
    let statLines = pokemonDetail?.stats.map { "\($0.stat.name.capitalized): \($0.base_stat)" }.joined(separator: "\n") ?? "N/A"
    statsLabel.text = "Stats:\n" + statLines

    if let imageUrl = detail.sprites.front_default, let url = URL(string: imageUrl) {
      URLSession.shared.dataTask(with: url) { data, _, _ in
        guard let data = data else { return }
        DispatchQueue.main.async {
          self.imageView.image = UIImage(data: data)
        }
      }.resume()
    }
  }
}
