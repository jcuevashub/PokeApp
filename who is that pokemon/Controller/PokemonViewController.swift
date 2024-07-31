//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    lazy var pokemonManager = PokemonManager()
    lazy var imageManager = ImageManager()
    lazy var game = GameModel()
    
    var random4Pokemons: [PokemonModel] = []
    var correctAnswer: String = ""
    var correctAnswerImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        imageManager.delegate = self
        
        print(game.getScore())
        
        createButtons()
        pokemonManager.fetchPokemon()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print(sender.title(for: .normal)!)
    }
    
    func createButtons() {
        for button in answerButtons {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 10.0
        }
    }
}

extension PokemonViewController: PokemonManagerDelegate {
    func didUpdatePokemon(pokemon: [PokemonModel]) {
        random4Pokemons = pokemon.chosse(4)
        
        let index = Int.random(in: 0...3)
        let imageData = random4Pokemons[index].imageURL
        correctAnswer = random4Pokemons[index].name
        
        imageManager.fetchImage(url: imageData)
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
}

extension PokemonViewController: ImageManagerDelegate {
    func didUpdateImage(image: ImageModel) {
        print(image.imageUrl)
    }
    
    func didFailWithErrorImage(error: any Error) {
        print(error)
    }
    
    
}

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

extension Collection {
    func chosse(_ n: Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}
