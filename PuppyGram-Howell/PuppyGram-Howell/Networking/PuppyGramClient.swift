//
//  PuppyGramClient.swift
//  PuppyGram-Howell
//
//  Created by Cory Howell on 2/4/22.
//

import Foundation

class PuppyGramClient {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func setFlickrURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = "/services/feeds/photos_public.gne"
        components.queryItems = [
            URLQueryItem(name: "tags", value: "puppy"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]
        return components.url ?? URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?tags=puppy&format=json&nojsoncallback=1")
    }
    
    func fetchPuppies(completion: @escaping (Result<PuppyGram, DataResponseError>) -> Void) {
        
        guard let url = setFlickrURL() else {
            completion(.failure(DataResponseError.network))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
            else {
                completion(.failure(DataResponseError.network))
                return
            }
            
            let decoder = JSONDecoder()
            guard
                let decodedResponse = try? decoder.decode(PuppyGram.self, from: data)
            else {
                completion(.failure(DataResponseError.decoding))
                return
            }
            completion(.success(decodedResponse))
        }.resume()
    }
    
    func fetchPuppyImage(thumbnailURL: String, completion: @escaping (Result<Data?, DataResponseError>) -> Void) {
        guard let url = URL(string: thumbnailURL) else {
            completion(.failure(.network))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            completion(.success(data))
        }.resume()
    }
}

extension HTTPURLResponse {
    // ~= is a "range" or can be read as "contains"
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
