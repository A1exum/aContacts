//
//  GroupsAPI.swift
//  ios-course-l21
//
//  Created by Alex Founr on 02.06.2022.
//

import Foundation
//import SwiftyJSON

//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

final class GroupsAPI {

    func fetchGroups(completion: @escaping ([GroupModel])->()) {

        var urlComponents = URLComponents() //ascii/percent-encoding
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        
        //URL
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "646052700"),

            //URLQueryItem(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "extended", value: "1"),
            
            URLQueryItem(name: "fields", value: "members_count, description, verified"),
           
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
                
                let groupsResponse = try JSONDecoder().decode(GroupsResponse.self, from: data)
                let groups: [GroupModel] = groupsResponse.response.items
                print(groups)
                
                //Поставили задачу в очередь на главный поток - асинхронно
                DispatchQueue.main.async {
                    //print(Thread.current)
                    completion(groups)
                }
               
            } catch {
                print(error)
            }
        }
        session.resume()
    }

}
