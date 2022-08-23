//
//  DetailedViewController.swift
//  BeerApp
//
//  Created by Dillon Massey on 19/08/2022.
//

import Foundation
import UIKit

class DetailedViewController: UIViewController {
    // Gets populated by the segue
    var data: Beer?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var foodPairTitleLabel: UILabel!
    @IBOutlet weak var foodPairingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = data {
            
            nameLabel.text = data.name ?? "a"
            descriptionLabel.text = data.description ?? ""

            // Setup abv label, this is hidden by default
            if let abv = data.abv {
                abvLabel.isHidden = false
                abvLabel.text = "\(abv)%"
            }
            
            // Food pairing is optional, these labels are hidden by default
            if !data.food_pairing.isEmpty {
                foodPairTitleLabel.isHidden = false
                foodPairingLabel.isHidden = false
                
                // Add bullet points to each new note
                let foodPairingNotes = data.food_pairing.compactMap({$0}).joined(separator: "\n\u{2022} ")
                foodPairingLabel.text = "\u{2022} " + foodPairingNotes
            }
            
        }
    }
    
    
}
