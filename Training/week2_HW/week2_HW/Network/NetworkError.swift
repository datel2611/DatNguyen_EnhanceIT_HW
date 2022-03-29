//
//  NetworkError.swift
//  week2_HW
//
//  Created by Consultant on 09/01/1401 AP.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badDecode
    case other(Error)
}
