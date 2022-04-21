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
    var publisherCache: Published<[Int:Data]>.Publisher {get}
    
    func getMovies()
    func getTitle(by row: Int) -> String?
    func getOverview(by row: Int) -> String?
    func getMovieId(by row: Int) -> Int?
    func loadMoreMovies()
    func forceUpdate()
    func getImageData(by row: Int) -> Data?
    func saveFavourite(by row: Int)
    func removeFavourite(by row: Int)
    func getFavourite() -> [Movie]
    
}

class MovieListViewModel : MovieListViewModelProtocol {
    
    var publisherMovies: Published<[Movie]>.Publisher {$movies}
    var publisherCache: Published<[Int:Data]>.Publisher {$cache}

    var totalRows: Int {movies.count}
    @Published private var cache: [Int: Data] = [:]
    var imageIndex = 0
    var movieId = [Int]()
    
    private let repository: Repository
    private var subcribers = Set<AnyCancellable>()
    @Published private(set) var movies = [Movie]()
    private var page: Int = 1
    private var isLoading = false

    
    
    init(repository: Repository){
        self.repository = repository
    }
    func getMovieId(by row: Int) -> Int?{
        return movieId[row]
    }
    func getMovies(){
        getMovies(from: NetworkURLs.urlBase)
    }
    func getTitle(by row: Int) -> String? {
        let movie = movies[row]
        return movie.title
    }
    func getOverview(by row: Int) -> String? {
        let movie = movies[row]
        return movie.overview
    }
    func loadMoreMovies(){
        let index = NetworkURLs.urlBase.index(NetworkURLs.urlBase.startIndex, offsetBy: 63)
        let range = index..<NetworkURLs.urlBase.index(after: index)
        let newURL = NetworkURLs.urlBase.replacingCharacters(in: range, with: "\(self.page + 1)")
        
        //print(newURL)
        
        getMovies(from: newURL)
    }
    func forceUpdate() {
        cache = [:]
        movies = []
        imageIndex = 0
        getMovies(from: NetworkURLs.urlBase, forceUpdate: true)
    }
    
    func saveFavourite(by row: Int){
        repository.saveFavourite(movies, row: row)
    }
    func removeFavourite(by movieId: Int){
        repository.removeFavourite(movieId: movieId)
    }
    func getFavourite() -> [Movie] {
        movies = repository.getFavourite()
        return movies
    }
    
    private func downloadInmagesFrom(_ movies: [Movie]){
        var temp = cache
        let group = DispatchGroup()
        for movie in movies {
            group.enter()
            
            let imageURL = "https://\(NetworkURLs.posterBaseURL)\(movie.posterPath ?? " ")"
            //print(imageURL)
            
            repository.getData(from: imageURL) { result in
                switch result{
                case .success(let data):
                    temp[self.imageIndex] = data
                    self.imageIndex += 1
                case .failure(let error):
                    print(error.localizedDescription)
                }
                group.leave()
            }
        }
        group.notify(queue: .main){ [weak self] in
            self?.cache = temp
        }
    }
    
    
    func getImageData(by row: Int) -> Data?{
        return cache[row]
    }
    private func getMovies(from url: String, forceUpdate: Bool = false) {
        guard !isLoading else {return}
        isLoading = true
        
        repository.getMovies(from: url){ [weak self] result in
            switch result{
            case .success(let tuple):
                if forceUpdate{
                    self?.movies = tuple.0
                    self?.movieId = tuple.2
                    //self?.repository.removeFavourite()
                } else {
                    self?.movies.append(contentsOf: tuple.0)
                    self?.movieId.append(contentsOf: tuple.2)
                    //print(self?.movieId)
                }
                self?.downloadInmagesFrom(tuple.0)
                self?.page = tuple.1
                self?.isLoading = false
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
//    private func downloadInmagesFrom(_ movies: [Movie]){
//
//        var temp = cache
//
//        let group = DispatchGroup()
//        for movie in movies {
//            group.enter()
//
//            let imageURL = "https://\(NetworkURLs.posterBaseURL)\(movie.posterPath ?? " ")"
//            //print(imageURL)
//
//            networkManager.getData(from: imageURL) { data in
//                if let data = data {
//                    temp[self.imageIndex] = data
//                    self.imageIndex += 1
//                }
//                group.leave()
//            }
//        }
//        group.notify(queue: .main){ [weak self] in
//            self?.cache = temp
//        }
//    }
    
//    private func getMovies(from url: String, forceUpdate: Bool = false) {
//        guard !isLoading else {return}
//        isLoading = true
//
//        networkManager
//            .getMovies(from: url)
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            } receiveValue: { [weak self] response in
//                var temp = [Movie]()
//                //print("in recive value")
//                for movie in response.movies{
//                    temp.append(movie)
//                }
//                if forceUpdate {
//                    self?.movies = temp
//                } else {
//                    self?.movies.append(contentsOf: temp)
//                }
//
//                self?.downloadInmagesFrom(temp)
//                self?.page = response.page
//                self?.isLoading = false
//            }
//            .store(in: &subcribers)
//    }
    
}

