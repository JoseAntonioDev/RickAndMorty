//
//  ProfileViewController.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 7/6/23.
//

import UIKit
import Foundation

class ProfileViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var specieLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!

    //MARK: Properties
    var characterSelected: Character?
    var imageToSet: UIImage?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Methods
    private func configureUI(){
        setLabels()
        characterImage.image = imageToSet
        let githubButton = UIButton(type: .custom)
        githubButton.setImage(UIImage(named: "github"), for: .normal)
        githubButton.addTarget(self, action: #selector(onGithubButtonPressed(sender:)), for: .touchUpInside)
        githubButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: githubButton)
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = .black
        self.title = characterSelected?.name
    }
    
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
            let stringToAppend = episode.replacingOccurrences(of: "https://rickandmortyapi.com/api/episode/", with: "", options: [.regularExpression, .caseInsensitive])
            episodes.append(stringToAppend)
        }
        
        let firstEp = episodes.first ?? ""
        let lastEp = episodes.last ?? ""
        let episodesString = (firstEp != lastEp) ? ("Episodes: " + firstEp + " ~ " + lastEp) : ("Episode: " + firstEp)

        
        return episodesString
    }
    
    @objc private func onGithubButtonPressed(sender: UIButton) {
        openGit()
    }
    
    func openGit() {
        guard let url = URL(string: "https://github.com/JoseAntonioDev") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
