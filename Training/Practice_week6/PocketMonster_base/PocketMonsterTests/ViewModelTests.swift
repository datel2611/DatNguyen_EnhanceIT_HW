//
//  PocketMonsterTests.swift
//  PocketMonsterTests
//
//  Created by Consultant on 07/02/1401 AP.
//

import XCTest
@testable import PocketMonster

class PocketMonsterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func test_loadPokemon() async throws {
//        //given
//        let viewModel = PokemonListViewModel(networkManager: MockNetworkManager())
//        //when
//        try await viewModel.loadPokemons()
//        //then
//        XCTAssertTrue(viewModel.pokemons[0].name == "bulbasaur")
//    }
    
    func test_downloadAllImages() async throws {
        //given
        let viewModel = PokemonListViewModel(networkManager: MockNetworkManager())
        let url = ["bulbasaur" : "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"]
        var result: [String:Data] = [:]
        var mockResult:[String:Data] = [:]

        //when
        let imagesLoader = ImagesLoader(urls: url, networkManager: NetworkManager())
        for try await response in imagesLoader {
            guard let key = response.keys.first, let value = response.values.first
            else { continue }
            result[key] = value
        }
        mockResult = try await viewModel.downloadAllImages(from: url)

        //then
        XCTAssertTrue(result == mockResult)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
