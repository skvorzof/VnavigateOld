//
//  ProfileSection.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 24.12.2022.
//

import UIKit

struct ProfileSection: Hashable {
    
    enum `Type`: Hashable {
        case info
        case photos
        case posts
    }
    
    enum Item: Hashable {
        case infoItem(ProfileInfoCellViewModel)
        case photosItem(ProfilePhotoCellViewModel)
        case postsItem(ProfilePostCellViewModel)
    }
    
    enum LayoutType {
        case infoLayout
        case photosLayout
        case postsLayout
    }
    
    let type: Type
    
    static let info = Self(type: .info)
    static let photos = Self(type: .photos)
    static let posts = Self(type: .posts)
    
    var layoutType: LayoutType {
        switch type {
        case .info:
            return .infoLayout
        case .photos:
            return .photosLayout
        case .posts:
            return .postsLayout
        }
    }
    
    init(type: Type) {
        self.type = type
    }
}
