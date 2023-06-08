//
//  Errors.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 7/6/23.
//

import Foundation
import UIKit

// List of errors that could happen during running the app
public enum Errors: Error {
    case invalidURL
    case unknownError
}

// Description of each
extension Errors: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL has been used"
        case .unknownError: return "Oops! An error has ocurred"
        }
    }
}

// Function that shows them
func showError(message: String, actualVC: UIViewController) {
    let alertVC = UIAlertController(title: "An Error Has Occurred", message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    actualVC.present(alertVC, animated: true, completion: nil)
}
