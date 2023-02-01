//
//  MockModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 13.12.2022.
//

struct Author: Decodable, Hashable {
    let name: String
    let profession: String
    let isFriend: Bool
    let avatar: String
    let photos: [Photo]
    let posts: [Post]
}

struct Photo: Decodable, Hashable {
    let photo: String
}

struct Post: Decodable, Hashable {
    let thumbnail: String
    let article: String
    let isLike: Bool
    let like: Int
    let isFavorites: Bool
}
