//
//  HomeViewModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 20.12.2022.
//

import UIKit

final class HomeViewModel {

    var dataSourceSnapshot = HomeListDiffableSnapshot()

    var friends: [Author] = []
    var posts: [Post] = []

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
            FetchService.shared.fetchSection(modelType: Author.self, fileName: "data") { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let authors):
                    self.makeHomeSectionData(data: authors)
                    self.dataSourceSnapshot = self.makeSnapshot(friends: self.friends, posts: self.posts)
                    self.state = .loaded
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            }
        }
    }

    private func makeHomeSectionData(data: [Author]) {
        data.forEach { author in
            if author.isFriend {
                friends.append(author)
            }

            author.posts.forEach { post in
                posts.append(post)
            }
        }
    }

    private func makeSnapshot(friends: [Author], posts: [Post]) -> HomeListDiffableSnapshot {
        var snapshot = HomeListDiffableSnapshot()

        snapshot.appendSections([.friends])
        snapshot.appendItems(friends.map { HomeSection.Item.friendsItem(HomeFriendCellViewModel(friend: $0)) }, toSection: .friends)

        snapshot.appendSections([.posts])
        snapshot.appendItems(
            posts.map {
                HomeSection.Item.postsItem(HomePostCellViewModel(post: $0))
            }, toSection: .posts)

        return snapshot
    }
}
