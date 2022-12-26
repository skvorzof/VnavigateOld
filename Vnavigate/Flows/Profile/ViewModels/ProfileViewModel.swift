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
    
    private var profile: Author = Author(name: "", profession: "", isFriend: false, avatar: "", photos: [], posts: [])
    private var photos: [Photo] = []
    private var posts: [Post] = []

    var updateState: ((State) -> Void)?

    private(set) var state: State = .initial {
        didSet {
            updateState?(state)
        }
    }

    func changeState(_ action: Action) {
        switch action {
        case .initial:
            state = .loading
            FetchService.shared.fetchProfileSection { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let model):
                    self.makeProfileSection(model: model)
                    self.dataSourceSnapshot = self.makeSnapshot(profile: self.profile, photos: self.photos, posts: self.posts)
                    self.state = .loaded
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            }
        }
    }

    private func makeProfileSection(model: [Author]) {
        for item in model {
            profile = Author(
                name: item.name, profession: item.profession, isFriend: item.isFriend, avatar: item.avatar, photos: [], posts: [])

            for photo in item.photos {
                photos.append(photo)
            }

            for post in item.posts {
                posts.append(post)
            }
        }
    }

    private func makeSnapshot(profile: Author, photos: [Photo], posts: [Post]) -> ProfileDiffableSnapshot {
        var snapshot = ProfileDiffableSnapshot()

        snapshot.appendSections([.info])
        snapshot.appendItems([.infoItem(ProfileInfoCellViewModel(profile: profile))], toSection: .info)

        snapshot.appendSections([.photos])
        snapshot.appendItems(photos.map { ProfileSection.Item.photosItem(ProfilePhotoCellViewModel(photo: $0)) }, toSection: .photos)

        snapshot.appendSections([.posts])
        snapshot.appendItems(posts.map { ProfileSection.Item.postsItem(ProfilePostCellViewModel(post: $0)) }, toSection: .posts)

        return snapshot
    }
}
