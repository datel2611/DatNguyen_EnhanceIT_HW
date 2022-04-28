//
//  PokemonCell.swift
//  PocketMonster
//
//  Created by Christian Quicano on 4/20/22.
//

import SwiftUI

struct PokemonCell: View {
    
    let name: String
    let imgData: Data?
    
    var body: some View {
        HStack {
            if let data = imgData, let image = UIImage(data: data) {
                Image(uiImage: image)
            } else {
                ProgressView().padding()
            }
            Text(name.capitalized)
                .font(.title)
                .bold()
        }
    }
}
