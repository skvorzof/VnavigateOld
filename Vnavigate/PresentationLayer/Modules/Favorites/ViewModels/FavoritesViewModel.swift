//
//  FavoritesViewModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 30.12.2022.
//

import Foundation

final class FavoritesViewModel {

    var dataSourceSnapshot = FavoritesDiffableSnapshot()

    var posts: [Post] = [] {
        didSet {
            dataSourceSnapshot = makeSnapshot(posts: posts)
        }
    }

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
            FetchService.shared.fetchSection(modelType: Post.self, fileName: "favorites") { result in
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.state = .loaded
                case .failure(let error):
                    self.state = .error(error.localizedDescription)
                }
            }
            self.dataSourceSnapshot = self.makeSnapshot(posts: posts)
            self.state = .loaded
        }
    }

    private func makeSnapshot(posts: [Post]) -> FavoritesDiffableSnapshot {
        var snapshot = FavoritesDiffableSnapshot()

        snapshot.appendSections([.posts])
        snapshot.appendItems(
            posts.map {
                FavoritesSection.Item.postsItem($0)
            }, toSection: .posts)
        return snapshot
    }
}
