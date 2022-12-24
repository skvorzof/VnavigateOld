//
//  ProfileViewModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import Foundation
import UIKit


final class ProfileViewModel {

    var dataSourceSnapshot = ProfileDiffableSnapshot()
    private let profile: Author
    private let photos: [Photo]
    private let posts: [Post]

    var updateState: ((State) -> Void)?

    private(set) var state: State = .initial {
        didSet {
            updateState?(state)
        }
    }

    init() {
        self.profile = Author(name: "1", profession: "2", isFriend: false, avatar: "0", photos: [], posts: [])
        self.photos = [Photo(photo: "0")]
        self.posts = [Post(thumbnail: "1", article: "1", isLike: true, like: 1, isFavorites: false)]
    }

    func changeState(_ action: Action) {
        switch action {
        case .initial:
            state = .loading
            self.dataSourceSnapshot = makeSnapshot(profile: profile, photos: photos, posts: posts)
            state = .loaded
        }
    }
    
    private func makeSnapshot(profile: Author, photos: [Photo], posts: [Post]) -> ProfileDiffableSnapshot {
        var snapshot = ProfileDiffableSnapshot()
        
        snapshot.appendSections([.info])
        snapshot.appendItems([.infoItem(ProfileInfoCellViewModel(profile: profile))], toSection: .info)
        
        snapshot.appendSections([.photos])
        snapshot.appendItems(photos.map{ProfileSection.Item.photosItem(ProfilePhotoCellViewModel(photo: $0))}, toSection: .photos)
        
        snapshot.appendSections([.posts])
        snapshot.appendItems(posts.map{ProfileSection.Item.postsItem(ProfilePostCellViewModel(post: $0))}, toSection: .posts)
        
        return snapshot
    }
}
