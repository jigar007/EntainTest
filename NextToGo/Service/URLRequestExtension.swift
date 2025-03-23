//
//  URLRequestExtension.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 23/3/2025.
//

import Foundation

extension URLRequest {
    public enum RequestHttpMethod: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
    }
}
