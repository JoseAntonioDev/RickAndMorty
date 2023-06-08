//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 6/6/23.
//

import Foundation
import UIKit

class CharacterCell: UICollectionViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var characterName: UILabel!
    
    var characterSelected: Character?
    var viewModel: ListOfCharactersViewModelProtocol?
    
    func configure(with character: Character) {
        activityIndicator.startAnimating()
        characterSelected = character
        let textArray = character.name.components(separatedBy: " ")
        let shortName = (textArray.count == 1) ? textArray[0] : (textArray[0] + " " + textArray[1])
        characterName.text = shortName
        
        guard let url = URL(string: character.image) else { return }
        let request = URLRequest(url: url)
        let dataResponse = try? URLSession.shared.synchronousDataTask(with: request)
        
        let image = UIImage(data: dataResponse?.data ?? Data())
        characterImage.layer.cornerRadius = (characterImage?.frame.size.width ?? CGFloat()) / 4
        characterImage?.clipsToBounds = true
        characterImage?.layer.borderWidth = 1.5
        characterImage?.layer.borderColor = UIColor.white.cgColor

        characterImage.image = image
        activityIndicator.stopAnimating()
    }
    
}

extension URLSession {

    func synchronousDataTask(with request: URLRequest) throws -> (data: Data?, response: HTTPURLResponse?) {
        let semaphore = DispatchSemaphore(value: 0)
        var responseData: Data?
        var theResponse: URLResponse?
        var theError: Error?

        dataTask(with: request) { (data, response, error) -> Void in
            responseData = data
            theResponse = response
            theError = error

            semaphore.signal()
        }.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        if let error = theError {
            throw error
        }

        return (data: responseData, response: theResponse as! HTTPURLResponse?)
    }

}
