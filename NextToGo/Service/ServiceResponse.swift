//
//  ServiceResponse.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 23/3/2025.
//

import Foundation

struct ServiceResponse {
    let data: Data
    let response: URLResponse
    
    func parse<T: Decodable>(_ type: T.Type) throws -> T {
        // Validate HTTP response status first
        try validateHTTPResponse()
        
        // Decode the data into the specified type
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            // Log raw data for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Failed to decode data: \(jsonString)")
            }
            throw ServiceError.decodingError(underlyingError: error)
        }
    }
    
    /// Validates the HTTP response status code
    /// - Throws: ServiceError if the status code indicates an error
    private func validateHTTPResponse() throws {
        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            
            switch statusCode {
            case 200...299:
                // Success range: proceed
                return
                
            case 400:
                throw ServiceError.badRequest(message: "Bad request - check your parameters")
            case 401:
                throw ServiceError.unauthorized(message: "Authentication required")
            case 403:
                throw ServiceError.forbidden(message: "Access denied")
            case 404:
                throw ServiceError.notFound(message: "Resource not found")
            case 429:
                throw ServiceError.tooManyRequests(message: "Rate limit exceeded")
                
            case 500:
                throw ServiceError.serverError(message: "Internal server error")
            case 502:
                throw ServiceError.badGateway(message: "Bad gateway")
            case 503:
                throw ServiceError.serviceUnavailable(message: "Service unavailable")
            case 504:
                throw ServiceError.gatewayTimeout(message: "Gateway timeout")
                
            default:
                throw ServiceError.unhandledStatusCode(code: statusCode, message: "Unexpected HTTP status code")
            }
        }
    }
}
