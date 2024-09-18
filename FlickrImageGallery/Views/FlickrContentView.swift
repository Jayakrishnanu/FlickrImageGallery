//
//  FlickrContentView.swift
//  FlickrImageGallery
//
//  Created by Jayakrishnan u on 9/18/24.
//

import SwiftUI
import Combine

struct FlickrContentView: View {
    @State private var items: [Item] = []
    @State private var search: String = ""
    
    private let networkService: NetworkService
    @State private var cancellables: Set<AnyCancellable> = []
    private var searchSubject = CurrentValueSubject<String, Never>("")
    var columnsAdaptive = [GridItem(.adaptive(minimum: 120))]
    
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    private func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { searchText in
                loadImages(search: searchText)
            }.store(in: &cancellables)
        
    }
    
    private func loadImages(search: String) {
        networkService.fetchFromFlickrImages(search: search)
            .sink { _ in
                
            } receiveValue: { items in
                self.items = items
            }.store(in: &cancellables)
        
    }
    
    var body: some View {
        NavigationStack {
            PhotoGridView(searchResult: items)
                .navigationTitle("Flickr")
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationTitle("Flickr")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setupSearchPublisher()
        }
        .searchable(text: $search)
        .onChange(of: search) {
            searchSubject.send(search)
        }
        
    }
}


#Preview {
    FlickrContentView(networkService: NetworkService())
}
