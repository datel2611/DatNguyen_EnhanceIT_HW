//
//  PokemonDetails.swift
//  PocketMonster
//
//  Created by Christian Quicano on 4/20/22.
//

import Foundation

struct PokemonDetails: Decodable {
    let id: Int
    let sprites: Sprites
    let abilities: [PokemonAbility]
    struct Sprites: Decodable {
        let frontDefault: String
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
