//
//  WelcomeView.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 7/6/23.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //MARK: Properties
    var viewModel: ListOfCharactersViewModelProtocol? = ListOfCharactersViewModel()
    enum Constants {
        static let navigationBarTitle: String = "Rick And Morty"
        static let githubAsset: String = "github"
        static let githubUrl: String = "https://github.com/JoseAntonioDev"
        static let ListOfCharactersViewControllerID: String = "ListOfCharactersViewController"
    }

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(with: viewModel)
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        viewModel?.isLoading.remove(observer: self)
    }
    
    //MARK: - Methods
    private func bind(with: ListOfCharactersViewModelOuput?) {
        viewModel?.items.observe(on: self) { [weak self] items in
            if items.count > 0 {
                self?.pushListOfCharacters()
            }
        }
        
        viewModel?.isLoading.observe(on: self, observerBlock: { [weak self] isLoading in
            isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        })
        
        viewModel?.error.observe(on: self) {error in
            if error != nil {
                showError(message: (error?.localizedDescription ?? ""), actualVC: self)
            }
        }
    }
    
    private func configureUI(){
        let githubButton = UIButton(type: .custom)
        githubButton.setImage(UIImage(named: Constants.githubAsset), for: .normal)
        githubButton.addTarget(self, action: #selector(onGithubButtonPressed(sender:)), for: .touchUpInside)
        githubButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: githubButton)
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = .black
        self.title = Constants.navigationBarTitle
    }
    
    @objc private func onGithubButtonPressed(sender: UIButton) {
        openGit()
    }
    
    func openGit() {
        guard let url = URL(string: Constants.githubUrl) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
        
    func pushListOfCharacters() {
        guard let listOfCharactersViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.ListOfCharactersViewControllerID) as? ListOfCharactersViewController else { return }
        listOfCharactersViewController.viewModel = self.viewModel
        self.navigationController?.pushViewController(listOfCharactersViewController, animated: true)
    }
    
    @IBAction func onStartButtonPressed(_ sender: UIButton) {
        viewModel?.items.value = []
        Task {
            await viewModel?.getAllCharacters()
        }
    }

}
