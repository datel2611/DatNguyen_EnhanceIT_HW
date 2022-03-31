//
//  NetworkManager.swift
//  week2_HW
//
//  Created by Consultant on 08/01/1401 AP.
//

import Foundation

enum CustomResult <Success, Failure> where Failure: Error{
    case success (Success)
    case failure (Failure)
}

internal class NetworkManager{
    
    var postItems = [PostItem]()
    
    func getPost(completionHandler: @escaping (Result<Post, NetworkError>)-> Void)  {
        guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=Q9YNbzmt8C5OpY7L3MV4DHJhrdIGCbjx3tVWxRcf&sol=2000&page=1")
        else{
            completionHandler(.failure(.badURL))
            return
            
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(.other(error)))
                //print(error.localizedDescription)
            }
            //print("data: \(data)")
            self.postItems = []
            if let data = data {
                do {
                    let posts = try  JSONDecoder().decode(Post.self, from: data)
                    //print(post)
                    posts.photos.forEach {
                        
                        let id = $0.id
                        let imageURL = $0.img_src
                        var status = false
                        
//                        if id == 654002 {
//                            status = true
//                        }
                        
                        
                        let item = PostItem(id: id, img_src: imageURL, status: status)
                        self.postItems.append(item)
                    }
                    
                    //print("PostItems: \(self.postItems)")
                    
                    
                    completionHandler(Result.success(posts))
                    
                }
                catch (let error){
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
