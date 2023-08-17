//
//  GamesController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/12/23.
//

import Foundation

class GamesController {
    
    //Shared Instance
    static let shared = GamesController()
    
    //MARK: - String Constants
    let baseURL = URL(string: "https://api.twitch.tv/helix/games")
    let accessToken = "Bearer vngp6bfybe5gcc7xw1b8oa7pchmdxf"
    let clientID = "x2uu2is6vpp7txiu622upcffc94o8r"
    let topGamesEndpoint = "/top"
    let baseImageURL = URL(string: "https://static-cdn.jtvnw.net/ttv-boxart")
    let heightWidth80x80Endpoint = "-80x80.jpg"
    let heightWidth160x160Endpoint = "-160x160.jpg"
    let heightWidth120x120Endpoint = "-120x120.jpg"
    

    //MARK: - Methods
    
    func imageURLFormatter80x80(id: String) -> URL {
        guard let baseImageURL = baseImageURL else { return URL(fileURLWithPath: "https://static-cdn.jtvnw.net/ttv-boxart") }
        
        let imageEndpoint = id + heightWidth80x80Endpoint
        
        let imageURL = baseImageURL.appending(path: imageEndpoint)
        
        return imageURL
    }
    
    func imageURLFormatter120x120(id: String) -> URL {
        guard let baseImageURL = baseImageURL else { return URL(fileURLWithPath: "https://static-cdn.jtvnw.net/ttv-boxart") }
        
        let imageEndpoint = id + heightWidth120x120Endpoint
        
        let imageURL = baseImageURL.appending(path: imageEndpoint)
        
        return imageURL
    }
    
    func imageURLFormatter160x160(id: String) -> URL {
        guard let baseImageURL = baseImageURL else { return URL(fileURLWithPath: "https://static-cdn.jtvnw.net/ttv-boxart") }
        
        let imageEndpoint = id + heightWidth160x160Endpoint
        
        let imageURL = baseImageURL.appending(path: imageEndpoint)
        
        return imageURL
    }
    
    //CRUD Functions
    func getPopularGames(completion: @escaping (Result<[GameData], GameError>) -> Void) {
        
         //Build URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
         let topGamesURL = baseURL.appending(path: topGamesEndpoint)
         
         //Create Header
         var request = URLRequest(url: topGamesURL)
         request.httpMethod = "GET"
         request.addValue(accessToken, forHTTPHeaderField: "Authorization")
         request.addValue(clientID, forHTTPHeaderField: "Client-Id")
        
        print(topGamesURL)
         
         //Data Task
         URLSession.shared.dataTask(with: request) { data, response, error in
             
             guard let data = data else { return completion(.failure(.noData)) }
             
             if let error = error {
                 print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
             }
             
             if let response = response as? HTTPURLResponse {
                 if response.statusCode != 200 {
                     print("Get Popular Games Status Code: \(response.statusCode)")
                 }
             }
             
             do {
                 let gameData = try JSONDecoder().decode(Game.self, from: data)
                 return completion(.success(gameData.data))
             } catch let error {
                 print (error.localizedDescription)
                 return completion(.failure(.unableToDecode))
             }
             
         }.resume()
    }
    
    func getSearchedGame(name: String, completion: @escaping (Result<[GameData], GameError>) -> Void) {
        //Build URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = [URLQueryItem(name: "name", value: name)]
        guard let componentsURL = components?.url else { return completion(.failure(.invalidURL)) }
        print(componentsURL)
        
        //Create Header
        var request = URLRequest(url: componentsURL)
        request.httpMethod = "GET"
        request.addValue(accessToken, forHTTPHeaderField: "Authorization")
        request.addValue(clientID, forHTTPHeaderField: "Client-Id")
        
        //Data Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("Search Game Status Code: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let gameData = try JSONDecoder().decode(Game.self, from: data)
                return completion(.success(gameData.data))
            } catch let error {
                print (error.localizedDescription)
                return completion(.failure(.unableToDecode))
            }
            
        }.resume()
        
    }
    
    
}//End Of Class
