//
//  ImageData.swift
//  who is that pokemon
//
//  Created by Jackson Cuevas on 29/7/24.
//

import Foundation

struct ImageData: Codable {
    let sprites: Sprites
}

class Sprites: Codable {
    let other: Other?
    
    init(other: Other?) {
        self.other = other
    }
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork?
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault, frontShiny: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
