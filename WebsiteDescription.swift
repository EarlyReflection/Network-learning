//
//  WebsiteDescription.swift
//  Network learning
//
//  Created by Vladimir Dvornikov on 05.11.2022.
//

import Foundation

struct websiteDescription: Decodable {
    
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}

