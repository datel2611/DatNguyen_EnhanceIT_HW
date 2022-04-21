//
//  Repository.swift
//  DN_Homework_3
//
//  Created by Consultant on 29/01/1401 AP.
//

import Foundation

class Repository: RepositoryProtocol {

    let remote: RemoteRepositoryProtocol
    let local: LocalRepositoryProtocol
    
    init( remote: RemoteRepositoryProtocol, local: LocalRepositoryProtocol) {
        self.remote = remote
        self.local = local
    }
    
    func getMovies(from url: String, _ completionHandler: @escaping (Result<SuccessResponse, NetworkError>) -> Void) {
        remote.getMovies(from: url, completionHandler)
    }

    func getData(from url: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        remote.getData(from: url, completionHandler: completionHandler)
    }
    
    func getFavourite()  {
        local.getFavourite()
    }
    
    func saveFavourite(_ movies: [Movie], row: Int) {
        local.saveFavourite(movies, row: row)
    }
    
    func removeFavourite(movieId: Int) {
        local.removeFavourite(movieId: movieId)
    }
    
}
