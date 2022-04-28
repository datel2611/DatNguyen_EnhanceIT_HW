//
//  PokemonDetailsView.swift
//  PocketMonster
//
//  Created by Christian Quicano on 4/21/22.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    let pokemon: PokemonData
    
    var body: some View {
        VStack {
            Text(pokemon.name)
                .font(.largeTitle)
            if let data = pokemon.imgData, let img = UIImage(data: data) {
                Image(uiImage: img)
                    .resizable()
                    .frame(width: 300, height: 300)
            }
            Text("Abilities")
                .font(.title)
            ForEach(pokemon.abilities) { ability in
                Text(ability.ability.name)
            }
        }
    }
}
