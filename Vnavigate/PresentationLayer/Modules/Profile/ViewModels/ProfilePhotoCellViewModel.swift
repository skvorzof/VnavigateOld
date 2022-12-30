//
//  ProfilePhotoCellViewModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 24.12.2022.
//

import Foundation

struct ProfilePhotoCellViewModel: Hashable {
    
    let photoImage: String
    
    init(photo: Photo) {
        photoImage = photo.photo
    }
}
