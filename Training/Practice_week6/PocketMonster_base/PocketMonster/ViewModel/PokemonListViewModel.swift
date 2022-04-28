//
//  PokemonListViewModel.swift
//  PocketMonster
//
//  Created by Christian Quicano on 4/20/22.
//

import Foundation

class PokemonListViewModel: ObservableObject {
    
    @Published private(set) var pokemons: [PokemonData] = []
    
    //private var networkManager = NetworkManager()
    var networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    @MainActor
    func loadPokemons() async throws {
        // getting pokemon list
        networkManager.url = NetworkURL.pokemonsNamesURL
        let pokemonResponse = try await networkManager.getResponseType(PokemonResponse.self)
        let pokemonsResult = pokemonResponse.results
        var urls: [String: String] = [:]
        for pokemon in pokemonsResult {
            networkManager.url = pokemon.urlDetails
            let pokemonDetails = try await networkManager.getResponseType(PokemonDetails.self)
            urls[pokemon.name] = pokemonDetails.sprites.frontDefault
            let pokemonData = PokemonData(id: pokemonDetails.id, name: pokemon.name, imgURL: pokemonDetails.sprites.frontDefault, abilities: pokemonDetails.abilities)
            pokemons.append(pokemonData)
        }
        let images = try await downloadAllImages(from: urls)
        // set images to pokemons
        let temp = pokemons.map { pokemon -> PokemonData in
            var pokemon = pokemon
            pokemon.imgData = images[pokemon.name]
            return pokemon
        }
        pokemons = temp
    }

    
    func downloadAllImages(from urls: [String: String]) async throws -> [String: Data] {
        var result: [String: Data] = [:]
        let imagesLoader = ImagesLoader(urls: urls, networkManager: networkManager)
        for try await response in imagesLoader {
            guard let key = response.keys.first, let value = response.values.first
            else { continue }
            result[key] = value
        }
        return result
    }
}
