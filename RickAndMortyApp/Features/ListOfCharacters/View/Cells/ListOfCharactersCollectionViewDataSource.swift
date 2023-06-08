//
//  ListOfCharactersCollectionViewDataSource.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 7/6/23.
//

import Foundation
import UIKit

class ListOfCharactersCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private let viewModel: ListOfCharactersViewModelProtocol?
    private let collectionView: UICollectionView
    
    init(
        with viewModel: ListOfCharactersViewModelProtocol?,
        collectionView: UICollectionView
    ) {
        self.viewModel = viewModel
        self.collectionView = collectionView
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: "CharacterCell", bundle: Bundle(for: RickAndMortyApp.self)), forCellWithReuseIdentifier: "CharacterCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.items.value.count == 0) ? 1 : (viewModel?.items.value.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if let character = viewModel?.items.value[indexPath.row] {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
             cell.configure(with: character)
             cell.viewModel = self.viewModel
             self.viewModel?.cells.value.append((cell, indexPath.item))
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
}
