//
//  PokemonAbility.swift
//  PocketMonster
//
//  Created by Christian Quicano on 4/21/22.
//

import Foundation

struct PokemonAbility: Decodable, Identifiable {
    let id = UUID()
    let ability: Ability
    struct Ability: Decodable {
        let name: String
    }
}
