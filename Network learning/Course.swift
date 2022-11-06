//
//  Course.swift
//  Network learning
//
//  Created by Vladimir Dvornikov on 05.11.2022.
//

import Foundation

struct Course: Decodable {
    
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
