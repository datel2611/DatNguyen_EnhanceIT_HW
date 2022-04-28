//
//  ImagesLoader.swift
//  PocketMonster
//
//  Created by Christian Quicano on 4/21/22.
//

import Foundation

class ImagesLoader: AsyncSequence, AsyncIteratorProtocol {
    
    typealias Element = [String: Data]
    
    private var urls: [String: String] = [:]
    private var networkManager: NetworkManagerProtocol
    
    init(urls: [String: String], networkManager: NetworkManagerProtocol) {
        self.urls = urls
        self.networkManager = networkManager
    }
    
    func next() async throws -> Element? {
        try await getNextData()
    }
    
    func makeAsyncIterator() -> ImagesLoader { self }
    
    private func getNextData() async throws -> [String: Data]? {
        guard let dictionary = urls.popFirst() else { return nil }
        networkManager.url = dictionary.value
        let data = try await networkManager.getData()
        return [dictionary.key: data]
    }
}
