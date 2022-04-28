//
//  MockNetworkManager.swift
//  PocketMonsterTests
//
//  Created by Consultant on 07/02/1401 AP.
//

import Foundation
@testable import PocketMonster

class MockNetworkManager: NetworkManagerProtocol {
    
    var url: String = ""
    var data: Data?

    func getResponseType<ResponseType>(_ type: ResponseType.Type) async throws -> ResponseType where ResponseType : Decodable {
        if type == PokemonResponse.self {
            data = fileDataLoader(filename: "response", extention: "json")
        } else {
            data = fileDataLoader(filename: "detail", extention: "json")
        }
        
        let result = try JSONDecoder().decode(ResponseType.self, from: data!)
        return result
    }
    
    func getData() async throws -> Data {
        fileDataLoader(filename: "1", extention: "png")
    }
    
    func createURL() throws -> URL {
        guard let url =  URL(string: self.url) else {
            throw NSError(domain: "can not create url", code: 500)
        }
        return url
    }
    
    func fileDataLoader(filename: String, extention: String) -> Data {
        let bundle = Bundle(for: MockNetworkManager.self)
        guard let url = bundle.url(forResource: filename, withExtension: extention)
        else {return Data()}
        
        do {
            return try Data(contentsOf: url)
        } catch {
            return Data()
        }
    }
}
