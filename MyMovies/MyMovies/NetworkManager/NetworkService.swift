//
//  NetworkService.swift
//  MyMovies
//
//  Created by naseem on 18/11/2021.
//

import Foundation

class NetworkService {
    
    func loadMovies(url: String, completion: @escaping ([Movie]?) -> ()) {
        
        guard let url = URL(string: url) else {
            fatalError("URL is incorrect")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let moviesResponse = try? JSONDecoder().decode(MoviesResponse.self, from: data)
            
            if let moviesResponse = moviesResponse {
                
                DispatchQueue.main.async {
                    completion(moviesResponse.search)
                }
            }
            
        }.resume()
        
    }
    
}
