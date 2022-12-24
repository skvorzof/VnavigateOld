//
//  ProfileInfoCellViewModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 24.12.2022.
//

import Foundation

struct ProfileInfoCellViewModel: Hashable {
    
    let avatarImage: String
    let authorLabel: String
    let professionLabel: String
    
    init(profile: Author) {
        avatarImage = profile.avatar
        authorLabel = profile.name
        professionLabel = profile.profession
    }
}
