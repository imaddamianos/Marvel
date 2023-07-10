//
//  CharacterOptions.swift
//  Marvel
//
//  Created by iMad on 10/07/2023.
//

import Foundation

enum CharacterOption: CaseIterable {
    case favorite
    case unfavorite
}

extension CharacterOption {
    
    var title: String {
        switch self {
        case .favorite:
            return "Favorite"
        case .unfavorite:
            return "Remove from favorites"
        }
    }
    
}
