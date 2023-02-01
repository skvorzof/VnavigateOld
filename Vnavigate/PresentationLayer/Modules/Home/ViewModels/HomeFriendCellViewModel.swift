//
//  HomeFriendCellViewModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 01.02.2023.
//

import Foundation

struct HomeFriendCellViewModel: Hashable {
    let author: String
    let avatarImage: String
    
    
    init(friend: Author) {
        author = friend.name
        avatarImage = friend.avatar
    }
}
