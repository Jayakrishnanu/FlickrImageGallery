//
//  PhotoGridView.swift
//  FlickrImageGallery
//
//  Created by Jayakrishnan u on 9/18/24.
//

import SwiftUI

struct PhotoGridView: View {
    var searchResult: [Item]
    var columnsAdaptive = [GridItem(.adaptive(minimum: 120))]
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columnsAdaptive, spacing: 4) {
                ForEach(searchResult, id: \.self) { item in
                    NavigationLink(destination: FlickrDetailView(item: item)) {
                        CacheAsyncImage(url: URL(string: item.media.m)!) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(height: 150, alignment: .center)
                                    .aspectRatio(2/3, contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            case .failure(let _):
                                EmptyView()
                            case .empty:
                                HStack {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .red))
                                    Spacer()
                                }
                            @unknown default:
                                fatalError("Error")
                            }
                            
                        }
                    }
                    
                }
            }
            
        }
    }
}
