//
//  ProfilePostCellViewModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 24.12.2022.
//

import Foundation

struct ProfilePostCellViewModel: Hashable {
    
    let thumbnail: String
    let article: String
    let isLike: Bool
    let like: Int
    let isFavorites: Bool
    
    init(post: Post) {
        thumbnail = post.thumbnail
        article = post.article
        isLike = post.isLike
        like = post.like
        isFavorites = post.isFavorites
    }
}
