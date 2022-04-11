//
//  NetworkManager.swift
//  DN_Homework_3
//
//  Created by Consultant on 17/01/1401 AP.
//

import Foundation
import Combine
import UIKit

protocol NetworkManager {
    func getMovies(from url: String) -> AnyPublisher<APIResponse, NetworkError>
    //func testGetMovie(completionHandler: @escaping (Result<[Movie],NetworkError>) -> Void)

}

class MainNetworkManager: NetworkManager {
    
    private var subcribers = Set<AnyCancellable>()
    
    func getMovies(from url: String) -> AnyPublisher<APIResponse, NetworkError> {
        
        //print("URL: \(url)")
        
        guard let url = URL(string: url)
        else{return Fail<APIResponse, NetworkError>(error: .badURL).eraseToAnyPublisher()}

        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map{ result -> Data in
                return result.data
            }
            
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                return NetworkError.badURL
            }
            //.print("IN URL SESSION")
            .eraseToAnyPublisher()
        
    }
}
    
//    func testGetMovie(completionHandler: @escaping (Result<[Movie],NetworkError>) -> Void) {
//        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=6622998c4ceac172a976a1136b204df4")
//
//        else {
//            completionHandler(.failure(.badURL))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//
//            //print("IN URL SESSION")
//        if let error = error {
//            completionHandler(.failure(.other(error)))
//            return
//        }
//
//        if let data = data {
//            do {
//                let movies = try JSONDecoder().decode([Movie].self, from: data)
//                completionHandler(.success(movies))
//            } catch  {
//                completionHandler(.failure(.badDecode))
//            }
//        }
//            //print("SUCCESS getting data")
//    }.resume()
//
//    }

