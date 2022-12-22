//
//  ProfileViewModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import Foundation
import UIKit

struct ProfileData: Hashable {
    let info: Author
    let photos: [Photo]
    let posts: [Post]
}

enum ProfileSection: Int, CaseIterable {
    case info
    case photos
    case posts
}

final class ProfileViewModel {

    var dataSourceSnapshot = AuthorDetailDiffableSnapshot()
    
    var photosData: [Photo] = []
    var postsData: [Post] = []

    
    var profileData: ProfileData?

    var updateState: ((State) -> Void)?

    private(set) var state: State = .initial {
        didSet {
            updateState?(state)
        }
    }
    
    private func makeAllData(model: [AuthorsSections]) {
        model.forEach { item in
            photosData.append(contentsOf: item.items.first?.photos ?? [Photo(photo: "plus")])
            postsData.append(contentsOf: item.items.first?.posts ?? [Post(thumbnail: "", article: "", isLike: true, like: 0, isFavorites: false)])
        }
    }

    func changeState(_ action: Action) {
        switch action {
        case .initial:
            state = .loading
            FetchService.shared.fetchAuthorsSections { [weak self] result in
                switch result {
                case .success(let data):
                    self?.makeAllData(model: data)
                    self?.state = .loaded
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }

//    private func makeSnapshot() {
//        var snapshot = AuthorDetailDiffableSnapshot()
//        snapshot.appendSections(ProfileSection.allCases)
//
//        for section in ProfileSection.allCases {
//            snapshot.appendItems(authorData, toSection: section)
//        }
//    }

    private func makeData(with: Author) {

    }
}
