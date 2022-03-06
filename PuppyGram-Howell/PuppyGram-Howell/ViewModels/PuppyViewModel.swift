//
//  PuppyViewModel.swift
//  PuppyGram-Howell
//
//  Created by Cory Howell on 2/5/22.
//

import UIKit

enum FetchState {
    case fetchComplete
    case fetchError(_ message: String)
}

protocol PuppyViewModelDelegate: AnyObject {
    func didUpdateState(_ state: FetchState)
}

class PuppyViewModel {
    weak var delegate: PuppyViewModelDelegate?
    var puppies = [Puppy]()
    
    let client = PuppyGramClient()
    
    init(delegate: PuppyViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getPuppies() {
        client.fetchPuppies { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.didUpdateState(.fetchError(error.reason))
                print("Failed with Error \(error.localizedDescription) - \(error.reason)")
            case .success(let response):
                if let response = response.puppies {
                    self?.puppies.append(contentsOf: response)
                    self?.delegate?.didUpdateState(.fetchComplete)
                }
            }
        }
    }
    
    func getPuppyImage(puppy: Puppy, completion: @escaping (UIImage?) -> Void) {
        guard let thumbnailURL = puppy.media?.m else {
            // handle missing thumbnail ... placeholder image from assets.
            return
        }
        
        if let cachedImage = UIImage.imageCache.object(forKey: thumbnailURL as AnyObject) as? UIImage {
            print("returning cached image")
            completion(cachedImage)
            return
        }
        
        client.fetchPuppyImage(thumbnailURL: thumbnailURL) { result in
            guard let data = try? result.get() else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            image?.cache(with: thumbnailURL)
            completion(image)
        }
    }
}
