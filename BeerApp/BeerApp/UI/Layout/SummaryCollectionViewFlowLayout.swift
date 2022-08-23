//
//  SummaryCollectionViewFlowLayout.swift
//  BeerApp
//
//  Created by Dillon Massey on 21/08/2022.
//

import Foundation
import UIKit

public class SummaryCollectionViewFlowLayout: UICollectionViewFlowLayout {
    public override init() {
        super.init()
        scrollDirection = .vertical
        minimumLineSpacing = 0
        sectionInset = .zero
        
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        itemSize = UICollectionViewFlowLayout.automaticSize
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
