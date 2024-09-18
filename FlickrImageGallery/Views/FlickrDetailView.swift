//
//  FlickrDetailView.swift
//  FlickrImageGallery
//
//  Created by Jayakrishnan u on 9/18/24.
//

import SwiftUI

struct FlickrDetailView: View {
    var item: Item
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                AsyncImage(url: URL(string: item.media.m))
                    .scaledToFit()
                
                Group {
                    Text(item.description.html2String)
                        .padding(.vertical)
                    
                    Text("Author")
                        .font(.headline)
                    
                    Text(item.author.split(separator: "\"")[1])
                        .padding(.vertical)
                    
                    Text(formattedDate(item.published))
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }
            .navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
    
    func formattedDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        let date = dateFormatter.date(from: dateString)
        return dateFormatterPrint.string(from: date!)
    }
    
    func authorDetail(_ author: String) {
        
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

#Preview {
    FlickrDetailView(item: Item(
        title: "Cape Porcupines",
        media: Media(m: "https://live.staticflickr.com/65535/53999077542_8d6af4ff2f_m.jpg"),
        description: "Description Description Description Description Description", published: "2024-09-16T17:44:10Z", author: "nobody@flickr.com"))
}
