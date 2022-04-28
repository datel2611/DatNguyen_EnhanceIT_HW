//
//  PokemonData.swift
//  PocketMonster
//
//  Created by Christian Quicano on 4/20/22.
//

import Foundation

struct PokemonData: Identifiable {
    let id: Int
    let name: String
    let imgURL: String
    let abilities: [PokemonAbility]
    var imgData: Data?
}
