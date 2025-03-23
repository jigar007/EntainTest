//
//  ServiceRequest.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 21/3/2025.
//

import Foundation

// Further enhancement can be done to add Authentication, body parameters, headers etc.
protocol ServiceRequest {
    var endpoint: ServiceEndpoints { get }
    var session: URLSession { get }
    var httpMethod: URLRequest.RequestHttpMethod { get }
    var queryParameters: NSDictionary? { get }
}

extension ServiceRequest {
    var url: URL? {
        URL(string: endpoint.absolutePath)
    }
    
    func perform() async throws -> ServiceResponse {
        let urlRequest = try createURLRequest()
        let (data, response) = try await session.data(for: urlRequest)
        return ServiceResponse(data: data, response: response)
    }
    
    private func createURLRequest() throws -> URLRequest {
        guard let url, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        if let queryParams = queryParameters {
            urlComponents.queryItems = queryParams.map { (key, value) in
                URLQueryItem(name: String(describing: key), value: String(describing: value))
            }
        }
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }
}
