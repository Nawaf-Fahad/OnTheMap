//
//  User.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 07/02/2023.
//

import Foundation
struct UserDataResponse: Codable {
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
    }
}
