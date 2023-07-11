//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by iMad on 10/07/2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var descriptionLabel: UILabel!
        @IBOutlet weak var thumbnailImageView: UIImageView!
    let imageDownloader = ImageDownloader()
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    func setupView(){
        GFunction.shared.addLoader("Loading details")
               if let character = character {
                   nameLabel.text = character.name
                   descriptionLabel.text = character.description
                   imageDownloader.downloadImage(from: (character.thumbnail?.url)!) { image in
                       if let image = image {
                           // Handle the downloaded image
                           DispatchQueue.main.async {
                               GFunction.shared.removeLoader()
                               self.thumbnailImageView.image = image
                           }
                       } else {
                           // Handle the case where image download failed
                           print("Failed to download image.")
                       }
                   }
               }
    }

}
