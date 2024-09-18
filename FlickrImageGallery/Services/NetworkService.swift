//
//  NetworkService.swift
//  FlickrImageGallery
//
//  Created by Jayakrishnan u on 9/18/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badURL
}

class NetworkService {
    func fetchFromFlickrImages(search: String) -> AnyPublisher<[Item], Error> {
        guard let encodedSearch = search.urlEncoded,
              let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(encodedSearch)") else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .map(\.items)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Item], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
    }
}
