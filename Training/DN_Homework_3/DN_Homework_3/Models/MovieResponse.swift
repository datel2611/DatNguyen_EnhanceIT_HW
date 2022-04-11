//
//  ResultResponse.swift
//  DN_Homework_3
//
//  Created by Consultant on 16/01/1401 AP.
//

import Foundation


struct Movie : Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let overview: String?
    let posterPath: String?
    let title: String?
    var status = false

    enum CodingKeys : String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case overview
        case posterPath = "poster_path"
        case title
    }
}
