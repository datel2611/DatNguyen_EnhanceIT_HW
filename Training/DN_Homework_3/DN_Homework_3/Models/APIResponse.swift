//
//  MovieResponse.swift
//  DN_Homework_3
//
//  Created by Consultant on 16/01/1401 AP.
//

import Foundation

struct APIResponse : Codable {
    var page: Int
    let movies: [Movie]
//    let totalPages: Int
//    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
    }
}
