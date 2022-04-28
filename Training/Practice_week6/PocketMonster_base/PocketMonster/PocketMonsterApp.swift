//
//  PocketMonsterApp.swift
//  PocketMonster
//
//  Created by Christian Quicano on 4/20/22.
//

import SwiftUI

@main
struct PocketMonsterApp: App {
    
    private let viewModel = PokemonListViewModel()
    
    var body: some Scene {
        WindowGroup {
            PokemonListView()
                .environmentObject(viewModel)
        }
    }
}
