//
//  HomeViewModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 20.12.2022.
//

import UIKit

final class HomeViewModel {

    var dataSourceSnapshot = AuthorsListDiffableSnapshot()

    private(set) var authorsSections = [AuthorsSections]() {
        didSet {
            dataSourceSnapshot = makeSnapshot(from: authorsSections)
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
            FetchService.shared.fetchSection(modelType: AuthorsSections.self, fileName: "home") { [weak self] result in
                switch result {
                case .success(let authors):
                    self?.authorsSections = authors
                    self?.state = .loaded
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }

    private func makeSnapshot(from authorsSections: [AuthorsSections]) -> AuthorsListDiffableSnapshot {
        var snapshot = AuthorsListDiffableSnapshot()
        snapshot.appendSections(authorsSections)

        for section in authorsSections {
            snapshot.appendItems(section.items, toSection: section)
        }

        return snapshot
    }
}
