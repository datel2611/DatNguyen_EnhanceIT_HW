//
//  ContentView.swift
//  PocketMonster
//
//  Created by Christian Quicano on 4/20/22.
//

import SwiftUI

struct PokemonListView: View {
    
    @EnvironmentObject private var viewModel: PokemonListViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                let list = filterBy(searchText: searchText)
                ForEach(list) { pokemon in
                    NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
                        PokemonCell(name: pokemon.name, imgData: pokemon.imgData)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search pokemon")
            .navigationTitle("PokeDex")
        }
        .task {
            do {
                try await viewModel.loadPokemons()
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    private func filterBy(searchText: String) -> [PokemonData] {
        guard searchText.isEmpty else {
            let filtered = viewModel.pokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            return filtered
        }
        return viewModel.pokemons
    }
}
