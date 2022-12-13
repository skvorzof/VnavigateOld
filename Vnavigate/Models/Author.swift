//
//  Author.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 13.12.2022.
//

import UIKit

struct Author: Hashable {
    let name: String
    let profession: String
    let avatar: String
    let photos: [Photo]
    let posts: [Post]
}

struct Photo: Hashable {
    let photo: String
}

struct Post: Hashable {
    let thumbnail: String
    let text: String
    let like: Int
    let isFavorite: Bool
}
