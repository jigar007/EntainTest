//
//  ServiceEndpoint.swift
//  NextToGo
//
//  Created by Jigar Thakkar on 23/3/2025.
//

import Foundation

public enum ServiceEndpoints: String {
    case racing = "/rest/v1/racing/"
}

extension ServiceEndpoints {
    // Can switch over diff env and return the absolute path for the env
    public var absolutePath: String {
        Constants.prodBaseURL.rawValue + self.rawValue
    }
}
