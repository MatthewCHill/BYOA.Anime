//
//  AnimeQuote.swift
//  BYOA.Anime
//
//  Created by Matthew Hill on 2/22/23.
//

import Foundation

class AnimeQuote {
    
    let anime: String
    let character: String
    let quote: String
    
    init(anime: String, character: String, quote: String) {
        self.anime = anime
        self.character = character
        self.quote = quote
    }
}

extension AnimeQuote {
    
    enum Keys: String {
        
        case anime
        case character
        case quote
    }
    
    convenience init?(animeDict: [String : Any]) {
        guard let anime = animeDict[Keys.anime.rawValue] as? String,
              let character = animeDict[Keys.character.rawValue] as? String,
              let quote = animeDict[Keys.quote.rawValue] as? String else { return nil }
        
        self.init(anime: anime, character: character, quote: quote)
    }
}
