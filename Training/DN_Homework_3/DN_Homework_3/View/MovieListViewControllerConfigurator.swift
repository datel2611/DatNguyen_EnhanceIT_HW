//
//  MovieListViewControllerConfigurator.swift
//  DN_Homework_3
//
//  Created by Consultant on 29/01/1401 AP.
//

import Foundation

class MovieListViewControllerConfigurator{
    static func assemblingMVVM(view: MovieListVCProtocol) {
            let networkManager = MainNetworkManager()
            let remote = RemoteRepository(networkManager: networkManager)
            
            let coreDataManager = CoreDataManager()
            let local = LocalRepository(coreDataManager: coreDataManager)
            let repository = Repository(remote: remote, local: local)
        
            let viewModel = MovieListViewModel(repository: repository)
            view.viewModel = viewModel
        }
}
