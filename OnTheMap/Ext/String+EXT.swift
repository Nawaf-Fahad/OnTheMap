//
//  String+EXT.swift
//  OnTheMap
//
//  Created by Nawaf Alotaibi on 07/02/2023.
//

import Foundation
import UIKit
extension String {
    func isValidUrl() -> Bool {
        guard !self.isEmpty else { return false }
        guard let url = URL(string: self) else { return false }
        
        return UIViewController.canOpenUrl(url: url)
    }
}
