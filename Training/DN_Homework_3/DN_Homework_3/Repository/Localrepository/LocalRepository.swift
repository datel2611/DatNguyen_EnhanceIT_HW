//
//  LocalRepository.swift
//  DN_Homework_3
//
//  Created by Consultant on 28/01/1401 AP.
//

import Foundation
import CoreData

class LocalRepository: LocalRepositoryProtocol{
    
    let coreDataManager: CoreDataManagerProtocol
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func getFavourite() {
        let request: NSFetchRequest = CDFavourite.fetchRequest()
        let context = coreDataManager.mainContext
        do {
            let movies = try context.fetch(request)
            let favouriteMovies = movies.map{$0.createFavourite()}
            //print("fav movies: \(favouriteMovies)")
            //return favouriteMovies
        } catch (let error) {
            print(error.localizedDescription)
            //return []
        }
    }
    
    func saveFavourite(_ movies: [Movie], row: Int) {
        let context = coreDataManager.mainContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CDFavourite", in: context)
        else{return}
        
        let cdFavourite = CDFavourite(entity: entityDescription, insertInto: context)
        cdFavourite.title = movies[row].title
        cdFavourite.overview = movies[row].overview
        cdFavourite.id = Int64(movies[row].id!)
        print("save id: \(cdFavourite.id)")
        do {
            try context.save()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func removeFavourite( movieId: Int) {
        let request: NSFetchRequest = CDFavourite.fetchRequest()
        let context = coreDataManager.mainContext
        do {
            let movies = try context.fetch(request)
            for movie in movies{
                if movie.id == movieId{
                    context.delete(movie)
                    //print("remove: \(movie.title)")
                }
            }
            
//            print("remove: \(movies[row].title)")
//            context.delete(movies[row])
            
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    
}
