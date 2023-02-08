//
//  Student.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 07/02/2023.
//

import Foundation

struct StudentLocationsResponse: Codable {
    let results: [StudentLocation]
}
struct PostStudentLocationResponse: Codable {
    let createdAt: String
    let objectId: String
}
