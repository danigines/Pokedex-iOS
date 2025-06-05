//  PokemonListViewController.swift
//  Pokedex-MVC
//  Created by Daniel Garcia on 04/06/25.

import UIKit

class PokemonListViewController: UITableViewController {
  var pokemonList: [Pokemon] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Pokédex"
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    fetchPokemon()
  }
  
  func fetchPokemon() {
    PokeAPIService.shared.fetchPokemonList { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let pokemons):
          self?.pokemonList = pokemons
          self?.tableView.reloadData()
        case .failure(let error):
          print("Error: \(error.localizedDescription)")
        }
      }
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pokemonList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let pokemon = pokemonList[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = pokemon.name.capitalized
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedPokemon = pokemonList[indexPath.row]
    let detailVC = PokemonDetailViewController(nibName: "PokemonDetailViewController", bundle: nil)
    detailVC.pokemon = selectedPokemon
    navigationController?.pushViewController(detailVC, animated: true)
  }
}
