//
//  FlickrImageGalleryUITests.swift
//  FlickrImageGalleryUITests
//
//  Created by Jayakrishnan u on 9/18/24.
//

import XCTest
import Combine


final class FlickrImageGalleryUITests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    func testFlickrImages() throws {
        
        let httpClient = NetworkService()
        let expection = XCTestExpectation(description: "Received images")
        
        httpClient.fetchFromFlickrImages(search: "porcupine")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Request failed with error \(error)")
                }
            } receiveValue: { items in
                XCTAssertTrue(items.count > 0)
                expection.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expection], timeout: 5.0)
        
    }
    
}

