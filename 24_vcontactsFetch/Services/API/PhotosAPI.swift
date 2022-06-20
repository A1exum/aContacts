//
//  FriendsAPI.swift
//  ios-course-l21
//
//  Created by AlexFount on 26.05.2022.
//

import Foundation

//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

final class PhotosAPI {
    
    lazy var urlComponents: URLComponents = {
        var urlComponents = URLComponents() //ascii/percent-encoding
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        return urlComponents
    }()
    
    func fetchPhotos(completion: @escaping ([PhotoModel])->()) {

        //URL
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "646052700"),
            //  URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        
        //URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        //Send Request
        let session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            //print(Thread.current)
            print(data?.prettyJSON as Any)
            
            guard let data = data else { return }
            
            do {
                let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: data)
                let photos: [PhotoModel] = photosResponse.response.items
                print(photos)
                
                DispatchQueue.main.async {
                    print(Thread.current)
                    completion(photos)
                }
               
            } catch {
                print(error)
            }
        }
        session.resume()
    }
    
}
