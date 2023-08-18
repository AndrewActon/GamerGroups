//
//  TagController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/9/23.
//

import Foundation

class TagController {
    
    //Shared Instance
    static let shared = TagController()
    
    //MARK: - String Constants
    let baseURL = URL(string: "https://store.steampowered.com")
    let genereEndpoint = "/api/getgenrelist/"
    
    //MARK: - Methods
    
    func fetchGenres(completion: @escaping (Result<[Genre], TagError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let genreURL = baseURL.appending(path: genereEndpoint)
        print("Final URL: \(genreURL)")
        
        URLSession.shared.dataTask(with: genreURL) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("STEAM STATUS CODE: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let steamData = try JSONDecoder().decode(Tag.self, from: data)
                let genre = steamData.genres
                
                var arrayOfGenres: [Genre] = []
                
                for id in genre {
                    arrayOfGenres.append(id)
                }
                
                return completion(.success(arrayOfGenres))
                                
            } catch let error {
                print(error.localizedDescription)
                return completion(.failure(.unableToDecode))
            }
            
        }.resume()
        
    }
}//End of Class
