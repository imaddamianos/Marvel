//
//  HomeViewController.swift
//  Marvel
//
//  Created by iMad on 10/07/2023.
//

import UIKit

class HomeViewController: UIViewController {
    let marvelAPI = MarvelAPI.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        marvelAPI.characterService.getAllCharacters { characters, error in
            if let characters = characters {
                // Handle the retrieved characters
                print(characters)
            } else if let error = error {
                // Handle the error
                print("Error retrieving characters: \(error)")
            }
        }
    }
}


