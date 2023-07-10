//
//  HomeViewController.swift
//  Marvel
//
//  Created by iMad on 10/07/2023.
//

import UIKit

class HomeViewController: UIViewController {
    let marvelAPI = MarvelAPI.shared
    var charInfo: [Character] = []
    
    @IBOutlet weak var charactersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register TableView Cell
        self.charactersTableView.register(ThumbCharacterTableViewCell.nib, forCellReuseIdentifier: ThumbCharacterTableViewCell.identifier)
        
        
        marvelAPI.characterService.getAllCharacters { characters, error in
            if let characters = characters {
                // Handle the retrieved characters
                print(characters)
                self.charInfo = characters
                DispatchQueue.main.async {
                    // Update TableView with the data
                    self.charactersTableView.reloadData()
                }
            } else if let error = error {
                // Handle the error
                print("Error retrieving characters: \(error)")
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThumbCharacterTableViewCell.identifier, for: indexPath) as? ThumbCharacterTableViewCell else { fatalError("xib doesn't exist") }
        
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
        
    }
}


