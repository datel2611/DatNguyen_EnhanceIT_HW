//
//  MovieListViewModel.swift
//  DN_Homework_3
//
//  Created by Consultant on 17/01/1401 AP.
//

import Foundation
import Combine

protocol MovieListViewModelProtocol {
    var totalRows: Int {get}
    var publisherMovies: Published<[Movie]>.Publisher {get}
    func getMovies()
    func getTitle(by row: Int) -> String?
    func getOverview(by row: Int) -> String? 
    
}

class MovieListViewModel : MovieListViewModelProtocol {
    
    var publisherMovies: Published<[Movie]>.Publisher { $movies}
    var totalRows: Int {movies.count}
   
    
    private let networkManager: NetworkManager
    private var subcribers = Set<AnyCancellable>()
    @Published private(set) var movies = [Movie]()
    
    init(networkManager: NetworkManager){
        self.networkManager = networkManager
    }
    
    func getMovies(){
        
        //print("In get movies")
        networkManager
            .getMovies(from: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=6622998c4ceac172a976a1136b204df4")
            //.print()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                var temp = [Movie]()
                //print("in recive value")
                for movie in response.movies{
                    temp.append(movie)
                }
                self?.movies = temp
            }
            .store(in: &subcribers)
    }
    
    func getTitle(by row: Int) -> String? {
        let movie = movies[row]
        return movie.title
    }
    func getOverview(by row: Int) -> String? {
        let movie = movies[row]
        return movie.overview
    }
    
    
}

