//
//  StartupViewController.swift
//  BeerApp
//
//  Created by Dillon Massey on 20/08/2022.
//

import Foundation
import UIKit

class StartupViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let alertController = UIAlertController(title: "Message", message: "Something went wrong", preferredStyle: UIAlertController.Style.alert)
    
    override func viewDidLoad() {
        // Setup alert with handler incase we don't have any data to populate the next view
        let alertAction : UIAlertAction = UIAlertAction(title: "Try again?", style: .default, handler: { action in self.showNextView() })
        alertController.addAction(alertAction)
        
        showNextView()
    }
    
    /**
     Segue to SummaryCollectionViewController to show list of beer data
     - parameter segue : Identifier inputted on the segue in storyboard
     - parameter sender : Data to send to the next view
     
     - Note: ID currently "presentSummary" with type [Beer]r for sender.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let data = sender as? [Beer] {
            let destinationVC = segue.destination as? SummaryCollectionViewController
            destinationVC?.dataSource = data
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showNextView() -> Void {
        // Attempts to get the latest beer data from the Brewdog API
        // This will attempt to contact the server and fallback to what has been saved on disk previously
        BeerStorageManager.shared.retrieveLatestBeerData() { beerData in
            // No data found, show try again alert
            guard !beerData.isEmpty else {
                DispatchQueue.main.async {
                    self.present(self.alertController, animated: true)
                }
                return
            }
            // Show collectionView
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "presentSummary", sender: beerData)
            }
            
        }
    }
}
