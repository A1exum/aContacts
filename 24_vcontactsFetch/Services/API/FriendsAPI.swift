//
//  FriendsAPI.swift
//  ios-course-l21
//
//  Created by AlexFount on 26.05.2022.
//



import Foundation

//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

final class FriendsAPI {
    
    lazy var urlComponents: URLComponents = {
        var urlComponents = URLComponents() //ascii/percent-encoding
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        return urlComponents
    }()
    
    func fetchFriends(completion: @escaping (Result<[FriendModel], AppError>)->()) {

        //URL
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "646052700"),

            //URLQueryItem(name: "user_id", value: "Session.shared.userId"),
            //URLQueryItem(name: "user_id", value: "273251945"), 646052700

            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "fields", value: "online, city, photo_100, country, contacts, bdate"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        
        //URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        //Send Request
        let session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            print(Thread.current)
            print(data?.prettyJSON as Any)
            
            guard let data = data else { return }
            
            do {
                let friendsResponse = try JSONDecoder().decode(FriendsResponse.self, from: data)
                let friends: [FriendModel] = friendsResponse.response.items
                print(friends)
                
                DispatchQueue.main.async {
                    print(Thread.current)
                   completion(.success(friends))
                }
               
            } catch {
                print(error)
                completion(.failure(AppError.mappingError))
                

            }
        }
        session.resume()
    }
    
    func fetchFriendsOnline() {
        
        urlComponents.queryItems = []
        
    }
}
