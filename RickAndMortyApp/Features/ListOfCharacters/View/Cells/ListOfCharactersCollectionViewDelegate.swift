//
//  ListOfCharactersCollectionViewDelegate.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 7/6/23.
//

import Foundation
import UIKit

class ListOfCharactersCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var viewModel: ListOfCharactersViewModelProtocol?
    private let dataSource: ListOfCharactersCollectionViewDataSource?
    
    init(with viewModel: ListOfCharactersViewModelProtocol?, dataSource: ListOfCharactersCollectionViewDataSource?) {
        self.viewModel = viewModel
        self.dataSource = dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  (viewModel?.items.value.count == 0) ? 400 : 100
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (viewModel?.items.value.count != 0) {
            if let character = viewModel?.items.value[indexPath.row] {
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else { return }
                cell.viewModel = self.viewModel
                cell.configure(with: character)
                let cellSelected = self.viewModel?.cells.value.first(where: {$1 == indexPath.item})
                self.viewModel?.characterSelected.value = (cell.characterSelected , cell.characterImage.image)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
