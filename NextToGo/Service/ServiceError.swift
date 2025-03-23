//
//  ServiceError.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 23/3/2025.
//

import Foundation

// Custom error type with extensive cases
enum ServiceError: Error {
    // Client errors (400–499)
    case badRequest(message: String)
    case unauthorized(message: String)
    case forbidden(message: String)
    case notFound(message: String)
    case tooManyRequests(message: String)
    
    // Server errors (500–599)
    case serverError(message: String)
    case badGateway(message: String)
    case serviceUnavailable(message: String)
    case gatewayTimeout(message: String)
    
    // Other errors
    case unhandledStatusCode(code: Int, message: String)
    case decodingError(underlyingError: Error)
    
    var localizedDescription: String {
        switch self {
        case .badRequest(let message):
            return "Bad Request (400): \(message)"
        case .unauthorized(let message):
            return "Unauthorized (401): \(message)"
        case .forbidden(let message):
            return "Forbidden (403): \(message)"
        case .notFound(let message):
            return "Not Found (404): \(message)"
        case .tooManyRequests(let message):
            return "Too Many Requests (429): \(message)"
            
        case .serverError(let message):
            return "Server Error (500): \(message)"
        case .badGateway(let message):
            return "Bad Gateway (502): \(message)"
        case .serviceUnavailable(let message):
            return "Service Unavailable (503): \(message)"
        case .gatewayTimeout(let message):
            return "Gateway Timeout (504): \(message)"
            
        case .unhandledStatusCode(let code, let message):
            return "Unhandled Status Code (\(code)): \(message)"
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        }
    }
}
