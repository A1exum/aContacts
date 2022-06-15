//
//  Session.swift
//  24-oauthVK
//
//  Created by admin on 30.05.22.
//


import Foundation

//Service -> business logic -> manage token
final class Session {
    
    private init() {}
    
    static let shared = Session() //Global memory + contant -> shared object
    
    var token: String = ""
    var userId: String = ""
    var expiresIn: String = ""
    
    #warning("Отслеживал время токена")
    
    #warning("Сохранение токена в Keychain а остальное в UserDefaults")
}
