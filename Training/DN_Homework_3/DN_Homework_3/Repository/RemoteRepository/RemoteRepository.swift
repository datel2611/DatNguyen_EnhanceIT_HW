//
//  RemoteRepository.swift
//  DN_Homework_3
//
//  Created by Consultant on 29/01/1401 AP.
//

import Foundation
import Combine

class RemoteRepository: RemoteRepositoryProtocol {
    private let networkManager: NetworkManager
    private var subcribers = Set<AnyCancellable>()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getMovies(from url: String,_ completionHandler: @escaping (Result<SuccessResponse, NetworkError>) -> Void){
        networkManager
            .getMovies(from: url)
            .sink { _ in} receiveValue: { response in
                var temp = [Movie]()
                var movieId = [Int]()
                //print("in recive value")
                for movie in response.movies{
                    temp.append(movie)
                    movieId.append(movie.id!)
                }
                let movies = temp
                let page = response.page
                
                completionHandler(.success((movies,page,movieId)))
            }
            .store(in: &subcribers)
    }
    func getData(from url: String, completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        networkManager.getData(from: url) { data in
            if let data = data {
                completionHandler(.success(data))
            } else {
                completionHandler(.failure(.badURL))
            }
        }
    }
}

