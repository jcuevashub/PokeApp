//
//  PokemonData.swift
//  who is that pokemon
//
//  Created by Jackson Cuevas on 29/7/24.
//

import Foundation


struct PokemonData: Codable {
    let results: [Result]?
}

struct Result: Codable {
    let name: String?
    let url: String?
}
