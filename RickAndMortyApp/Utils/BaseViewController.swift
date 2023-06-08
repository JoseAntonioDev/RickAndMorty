//
//  BaseViewController.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 8/6/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    //MARK: Properties
    enum Constants {
        static let navigationBarTitle: String = "Rick And Morty"
        static let githubAsset: String = "github"
        static let githubUrl: String = "https://github.com/JoseAntonioDev"
        static let ListOfCharactersViewControllerID: String = "ListOfCharactersViewController"
    }

    
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

}

//MARK: - Keyboard methods
extension UIViewController {
    // These methods will be useful in the future when We implement a searchBar
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
