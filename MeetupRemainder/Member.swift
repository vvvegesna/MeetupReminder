//
//  Member.swift
//  MeetupRemainder
//
//  Created by Vegesna, Vijay V EX1 on 9/12/20.
//  Copyright © 2020 Vegesna, Vijay V. All rights reserved.
//

import SwiftUI
import MapKit

struct Member: Codable {
    
    let name: String
    let icon: CodableImage
    var instance: CodableMKPointAnnotation?
    
    init(name: String, image: UIImage, instance: CodableMKPointAnnotation?) {
        self.name = name
        let photoData = image.jpegData(compressionQuality: 0.8)!
        self.icon = CodableImage(photoData)
        self.instance = instance
    }
    
    var image: Image {
        guard let uiImage = UIImage(data: icon.photoData) else {
            return Image(systemName: "person")
        }
        return Image(uiImage: uiImage)
    }
    
    var location: CLLocationCoordinate2D? {
        instance?.coordinate
    }
    
}

class CodableImage: Codable {
    
    enum CodingKeys: CodingKey {
        case photoData
    }
    
    let photoData: Data
    
    init(_ photoData: Data) {
        self.photoData = photoData
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        photoData = try container.decode(Data.self, forKey: .photoData)
    }
}
