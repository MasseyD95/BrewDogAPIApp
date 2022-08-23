//
//  SummaryCollectionViewCompositionalLayout.swift
//  BeerApp
//
//  Created by Dillon Massey on 21/08/2022.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
public class SummaryCollectionViewCompositionalLayout: UICollectionViewCompositionalLayout {
    public init() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        super.init(section: section)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
