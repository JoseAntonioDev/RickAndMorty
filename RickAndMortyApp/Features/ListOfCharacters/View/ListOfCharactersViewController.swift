//
//  ListOfCharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 6/6/23.
//

import UIKit
import Foundation

class ListOfCharactersViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: Properties
    enum Constants {
        static let navigationBarTitle: String = "Select Your Character"
    }
    
    var dataSource: ListOfCharactersCollectionViewDataSource?
    var delegate: ListOfCharactersCollectionViewDelegate?
    var viewModel: ListOfCharactersViewModelProtocol?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(with: viewModel)
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.characterSelected.value = (nil, nil)
        configureCollectionView()
        collectionView.reloadData()
        hideKeyboardWhenTappedAround()
    }
    
    deinit {
        viewModel?.items.remove(observer: self)
        viewModel?.isLoading.remove(observer: self)
        viewModel?.characterSelected.remove(observer: self)
    }
    
    //MARK: - Methods
    private func bind(with: ListOfCharactersViewModelOuput?) {
        viewModel?.items.observe(on: self) { [weak self] items in
            self?.dataSource?.reloadData()
        }
        
        viewModel?.isLoading.observe(on: self, observerBlock: { [weak self] isLoading in
            isLoading ? self?.showLoading() : self?.dismiss(animated: false, completion: nil)
        })
        
        viewModel?.characterSelected.observe(on: self) { [weak self] characterSelected in
            if characterSelected.0 != nil {
                self?.pushProfileViewController(with: characterSelected.0, and: characterSelected.1 as? UIImage)
            }
        }
    }
    
    private func configureUI(){
        let githubButton = UIButton(type: .custom)
        githubButton.setImage(UIImage(named: "github"), for: .normal)
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
    
    private func configureCollectionView() {
        dataSource = ListOfCharactersCollectionViewDataSource(with: viewModel, collectionView: collectionView)
        delegate = ListOfCharactersCollectionViewDelegate(with: viewModel, dataSource: dataSource)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.keyboardDismissMode = .onDrag
        
        dataSource?.registerCells()
    }
    
    func showLoading() {
        let alert = UIAlertController(title: nil, message: "Loading", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func openGit() {
        guard let url = URL(string: "https://github.com/JoseAntonioDev") else {
          return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func pushProfileViewController(with character: Character?, and characterImage: UIImage?) {
        guard let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        profileViewController.characterSelected = character
        profileViewController.imageToSet = characterImage
        self.navigationController?.pushViewController(profileViewController, animated: true)

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
