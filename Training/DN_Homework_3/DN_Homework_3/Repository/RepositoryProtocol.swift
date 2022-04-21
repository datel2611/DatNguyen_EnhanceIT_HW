//
//  RepositoryProtocol.swift
//  DN_Homework_3
//
//  Created by Consultant on 28/01/1401 AP.
//

import Foundation

protocol RepositoryProtocol: RemoteRepositoryProtocol, LocalRepositoryProtocol {
    var remote: RemoteRepositoryProtocol{get}
    var local: LocalRepositoryProtocol{get}
}

typealias SuccessResponse = ([Movie], Int, [Int])
protocol RemoteRepositoryProtocol {
    func getMovies(from url: String,_ completionHandler: @escaping (Result<SuccessResponse, NetworkError>) -> Void)
    func getData(from url: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void)
}

protocol LocalRepositoryProtocol {
    func getFavourite() -> [Movie] 
    func saveFavourite(_ movies: [Movie], row: Int)
    func removeFavourite(movieId: Int)
}
