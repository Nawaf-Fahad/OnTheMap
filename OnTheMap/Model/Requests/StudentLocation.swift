//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 07/02/2023.
//

import Foundation
import MapKit
struct StudentLocation: Codable {
    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String? = nil
    let createdAt: String? = nil
    let updatedAt: String? = nil
    
    init(address: String, url: String, userId: String, location: CLLocationCoordinate2D) {
        self.firstName = "Nawaf"
        self.lastName = "Fahd"
        self.latitude = location.latitude
        self.longitude = location.longitude
        self.mapString = address
        self.mediaURL = url
        self.uniqueKey = userId
    }
    
    func copy(location: CLLocationCoordinate2D) -> StudentLocation {
        return StudentLocation(address: self.mapString, url: mediaURL, userId: self.uniqueKey, location: location)
    }
}

extension StudentLocation {
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    func toCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func toMKPointAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = toCoordinate2D()
        annotation.title = fullName
        annotation.subtitle = mediaURL
        return annotation
    }
}
