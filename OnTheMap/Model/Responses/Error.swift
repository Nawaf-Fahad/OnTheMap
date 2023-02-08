//
//  Error.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 07/02/2023.
//

import Foundation
struct ErrorResponse: Codable {
    let status: Int
    let error: String
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
