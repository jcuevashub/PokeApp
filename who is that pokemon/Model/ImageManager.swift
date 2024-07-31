//
//  ImageManager.swift
//  who is that pokemon
//
//  Created by Jackson Cuevas on 29/7/24.
//

import Foundation

protocol ImageManagerDelegate {
    func didUpdateImage(image: ImageModel)
    func didFailWithErrorImage(error: Error)
}

struct ImageManager {
    var delegate: ImageManagerDelegate?
    
    func fetchImage(url: String) {
        performRequest(with: url)
    }
    
  private func performRequest(with urlString: String) {
        //1. Create/get url
        if let url = URL(string: urlString) {
            //2. Create the URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithErrorImage(error: error!)
                }
                
                if let safeData = data {
                    if let image = self.parseJSON(imageData: safeData) {
                        self.delegate?.didUpdateImage(image: image)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    private func parseJSON(imageData: Data) -> ImageModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(ImageData.self, from: imageData)
            let image = decodeData.sprites.other?.officialArtwork?.frontShiny ?? ""
            return ImageModel(imageUrl: image)
        } catch {
            return nil
        }
    }
}
