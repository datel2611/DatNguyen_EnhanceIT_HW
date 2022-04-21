//
//  CDFavourite+Utils.swift
//  DN_Homework_3
//
//  Created by Consultant on 29/01/1401 AP.
//

import Foundation

extension CDFavourite {
    func createFavourite() -> Movie{
        return Movie(adult: nil, backdropPath: nil, id: Int(id), overview: overview, posterPath: posterPath, title: title)
    }
}
