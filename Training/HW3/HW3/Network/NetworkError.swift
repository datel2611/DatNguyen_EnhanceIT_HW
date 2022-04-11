//
//  NetworkError.swift
//  DN_Homework_3
//
//  Created by Consultant on 17/01/1401 AP.
//

import Foundation

enum NetworkError: Error{
    case badURL
    case badDecode
    case other(Error)
}
