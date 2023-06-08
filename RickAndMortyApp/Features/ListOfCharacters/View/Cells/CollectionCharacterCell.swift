//
//  CollectionCharacterCell.swift
//  RickAndMortyApp
//
//  Created by Jose Antonio Alvarez Vazquez on 7/6/23.
//

import Foundation
import UIKit

class CollectionCharacterCell: UITableViewCell {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var nameLabel: UILabel!
    
    private var cells: [Character] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }
    
    func configure(with model: Character, and items: [Character]) {
        cells = items
        nameLabel.text = model.name
        collectionView.reloadData()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .black
        
        registerCells()
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
    
}


extension CollectionCharacterCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -20, left: 20, bottom: 0, right: 5)
    }
}

extension CollectionCharacterCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 133, height: 198)
    }
}

extension CollectionCharacterCell: UICollectionViewDataSource {
    func registerCells() {
        let nib = UINib(nibName: "CharacterCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "CharacterCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = cells[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        cell.configure(with: model)

        return cell
    }
}
