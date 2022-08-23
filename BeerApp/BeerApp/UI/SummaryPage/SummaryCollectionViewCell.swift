//
//  SummaryCollectionViewCell.swift
//  BeerApp
//
//  Created by Dillon Massey on 19/08/2022.
//

import Foundation
import UIKit

class SummaryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "summaryCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var abvStrongImage: UIImageView!
    @IBOutlet weak var parentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add border to mimic card
        // These can be made into app wide constants in the future
        parentView.layer.borderWidth = 0.4
        
        // Support for Dark mode
        if #available(iOS 13.0, *) {
            parentView.layer.borderColor = UIColor.systemGray.cgColor
        } else {
            parentView.layer.borderColor = UIColor.gray.cgColor

        }
        parentView.layer.cornerRadius = 10
    }
}
