//
//  HomeViewController.swift
//  Marvel
//
//  Created by iMad on 10/07/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    let imageDownloader = ImageDownloader()
    let marvelAPI = MarvelAPI.shared
    var charInfo: [Character] = []
    
    @IBOutlet weak var charactersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register TableView Cell
        self.charactersTableView.register(ThumbCharacterTableViewCell.nib, forCellReuseIdentifier: ThumbCharacterTableViewCell.identifier)
        
        GFunction.shared.addLoader("Heroes are gettings ready !")
        marvelAPI.characterService.getAllCharacters { characters, error in
            if let characters = characters {
                // Handle the retrieved characters
                print(characters)
                self.charInfo = characters
            } else if let error = error {
                // Handle the error
                DispatchQueue.main.async {
                    GFunction.shared.showCustomAlert(title: "Error", message: "API request fail, check internet Connection", buttonText: "OK")
                }
                print("Error retrieving characters: \(error)")
            }
            DispatchQueue.main.async {
                // Update TableView with the data
                GFunction.shared.showSuccess()
                GFunction.shared.removeLoader()
                self.charactersTableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThumbCharacterTableViewCell.identifier, for: indexPath) as? ThumbCharacterTableViewCell else { fatalError("xib doesn't exist") }
        
        imageDownloader.downloadImage(from: (charInfo[indexPath.row].thumbnail?.url)!) { image in
            if let image = image {
                // Handle the downloaded image
                DispatchQueue.main.async {
                    // Update the UI with the downloaded image
                    cell.charImg.image = image
                }
            } else {
                // Handle the case where image download failed
                print("Failed to download image.")
            }
        }
        
//        cell.charImg.image = charInfo[indexPath.row].thumbnail
            cell.charNameLbl.text = charInfo[indexPath.row].name
//        cell.titleLabel.textColor = #colorLiteral(red: 0.2354828119, green: 0.2450637817, blue: 0.3699719906, alpha: 1)

        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = charInfo[indexPath.row] // Assuming you have an array of characters
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let characterDetailsVC = storyboard.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        characterDetailsVC.character = selectedCharacter
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }

}


