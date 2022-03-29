//
//  NetworkManager.swift
//  week2_HW
//
//  Created by Consultant on 08/01/1401 AP.
//

import Foundation



internal class NetworkManager{
    func getPost(completionHandler: @escaping (Result<[Post], NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=Q9YNbzmt8C5OpY7L3MV4DHJhrdIGCbjx3tVWxRcf&sol=2000&page=1")
        else{
            completionHandler(.failure(.badURL))
            return
            
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(.other(error)))
            }
            if let data = data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Any]]
                    print("The Result: \(String(describing: result))")
                    //let posts = try  JSONDecoder().decode([Post].self, from: data)
                    //completionHandler(.success(posts))
                    
                }
                catch {
                    completionHandler(.failure(.badDecode))
                }
            }
        }.resume()
    }
}
