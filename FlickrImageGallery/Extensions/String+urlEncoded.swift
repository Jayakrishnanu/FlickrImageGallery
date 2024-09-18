//
//  String+urlEncoded.swift
//  FlickrImageGallery
//
//  Created by Jayakrishnan u on 9/18/24.
//

import Foundation

extension String {
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
