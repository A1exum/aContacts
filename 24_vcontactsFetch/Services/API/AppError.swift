//
//  AppError.swift
//  24_vcontactsFetch
//
//  Created by Alex Fount on 9.06.22.
//

import Foundation

enum AppError: Error {
    case mappingError
    case noNetworkError
    case clientError
    case serverError
    
    var description: String {
        switch self {
        case .mappingError:
            return "Ошибка парсинга модели"
        case .noNetworkError:
            return "Отсутсвует интернет"
        case .clientError:
            return "Клиентская ошибка"
        case .serverError:
            return "Серверная ошибка"
        }
    }
}
