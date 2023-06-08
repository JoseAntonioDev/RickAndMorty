//
//  WelcomeView.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 7/6/23.
//

import Foundation
import UIKit

class WelcomeViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //MARK: Properties
    var viewModel: ListOfCharactersViewModelProtocol? = ListOfCharactersViewModel()
    enum Constants {
        static let ListOfCharactersViewControllerID: String = "ListOfCharactersViewController"
    }

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(with: viewModel)
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
