//
//  Post.swift
//  week2_HW
//
//  Created by Consultant on 09/01/1401 AP.
//

import Foundation

struct Post: Decodable {
    
    let photos: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case photos
        case id
    }
}
