//
//  SummaryCollectionViewController.swift
//  BeerApp
//
//  Created by Dillon Massey on 19/08/2022.
//

import Foundation
import UIKit

class SummaryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    static let segueIdentifier = "presentDetail"
    // Populated by the segue from StartupViewController
    var dataSource: [Beer]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        // Use compositional layout where possible
        if #available(iOS 13.0, *) {
            collectionView.collectionViewLayout = SummaryCollectionViewCompositionalLayout()
        } else {
            collectionView.collectionViewLayout = SummaryCollectionViewFlowLayout()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.reloadData()
    }
    
    /**
     Segue to DetailedViewController to show more information on the selected beer.
     - parameter segue : Identifier inputted on the segue in storyboard
     - parameter sender : Data to send to the next view
     
     - Note: ID currently "presentDetail" with type Beer for sender.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let data = sender as? Beer {
            let destinationVC = segue.destination as? DetailedViewController
            destinationVC?.data = data
        }
    }

    // MARK: Delegate Functions
    // Perform a segue to an instancce of DetailedViewController. Pass long the data with the segue to populate the next screen
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // present view ontop of this with the details
        if let beer = dataSource.first(where: { ($0.id - 1) == indexPath.item }) {
            performSegue(withIdentifier: "presentDetail", sender: beer)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let referenceHeight: CGFloat = 200 // Approximate height of the cell
                                           // Cell width calculation
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
        - sectionInset.left
        - sectionInset.right
        - collectionView.contentInset.left
        - collectionView.contentInset.right
        
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
    
    // MARK: DataSource functions
    // Dequeue an instance of SummaryCollectionViewCell and populate with values from our datasource.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCollectionViewCell.reuseIdentifier, for: indexPath) as! SummaryCollectionViewCell
        
        // IDs start from 1, decrement to compare against IndexPath.item
        guard let beerData = dataSource.first(where: { ($0.id - 1) == indexPath.item}) else {
            return cell
        }

        cell.nameLabel.text = beerData.name ?? "Unavailable"
        cell.taglineLabel.text = beerData.tagline ?? "Unavailable"
        
        // Populate ABV label, this is hidden by default if abv is nil
        if let abv = beerData.abv {
            cell.abvLabel.isHidden = false
            cell.abvLabel.text = "\(abv)%"
            // Show 'Strong icon' on beers over 5% abv, this is hidden by default in the view.
            cell.abvStrongImage.isHidden = abv < 5
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}
