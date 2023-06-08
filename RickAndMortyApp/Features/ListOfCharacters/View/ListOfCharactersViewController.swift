//
//  ListOfCharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 6/6/23.
//

import UIKit
import Foundation

class ListOfCharactersViewController: BaseViewController {

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
        self.title = Constants.navigationBarTitle
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.characterSelected.value = (nil, nil)
        configureCollectionView()
        collectionView.reloadData()
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
        
        viewModel?.characterSelected.observe(on: self) { [weak self] characterSelected in
            if characterSelected.0 != nil {
                self?.pushProfileViewController(with: characterSelected.0, and: characterSelected.1 as? UIImage)
            }
        }
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
    
    func pushProfileViewController(with character: Character?, and characterImage: UIImage?) {
        guard let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        profileViewController.characterSelected = character
        profileViewController.imageToSet = characterImage
        self.navigationController?.pushViewController(profileViewController, animated: true)

    }
    
}
