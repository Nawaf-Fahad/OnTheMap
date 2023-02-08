//
//  LoginReq.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 07/02/2023.
//

import Foundation
struct LoginRequest: Codable {
    let udacity: UdacityCredentials
    
    init(username: String, password: String) {
        udacity = UdacityCredentials(username: username, password: password)
    }
}
