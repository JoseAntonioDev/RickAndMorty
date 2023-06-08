//
//  ProfileViewController.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 7/6/23.
//

import UIKit
import Foundation

class ProfileViewController: BaseViewController {

    //MARK: Outlets
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var specieLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!

    //MARK: Properties
    enum Constants {
        static let urlEpisodesToTrim: String = "https://rickandmortyapi.com/api/episode/"
    }
    var characterSelected: Character?
    var imageToSet: UIImage?
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        characterImage.image = imageToSet
        self.title = characterSelected?.name
        setLabels()
    }
    
    //MARK: - Methods
    private func setLabels(){
        statusLabel.text = "Status: \(characterSelected?.status ?? "?")"
        genderLabel.text = "Gender: \(characterSelected?.gender ?? "?")"
        specieLabel.text = "Specie: \(characterSelected?.species ?? "?")"
        originLabel.text = "Origin: \(characterSelected?.origin.name ?? "?")"
        locationLabel.text = "Status: \(characterSelected?.location.name ?? "?")"
        episodesLabel.text = trimEpisodes(characterSelected?.episode ?? [])
    }
    
    func trimEpisodes(_ episodesToTrim: [String]) -> String {
        var episodes: [String] = []
        episodesToTrim.forEach { episode in
            let stringToAppend = episode.replacingOccurrences(of: Constants.urlEpisodesToTrim, with: "", options: [.regularExpression, .caseInsensitive])
            episodes.append(stringToAppend)
        }
        
        let firstEp = episodes.first ?? ""
        let lastEp = episodes.last ?? ""
        let episodesString = (firstEp != lastEp) ? ("Episodes: " + firstEp + " ~ " + lastEp) : ("Episode: " + firstEp)

        return episodesString
    }
    
}
