//
//  HomeViewModel.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 20.12.2022.
//

import UIKit

final class HomeViewModel {

    var dataSourceSnapshot = AuthorsListDiffableSnapshot()

    var authorsSections = [AuthorsSections]() {
        didSet {
            dataSourceSnapshot = makeSnapshot(from: authorsSections)
        }
    }

    var showError: ((String) -> Void)?

    func loadData() {
        FetchService.shared.fetchAuthorSection { [weak self] result in
            switch result {
            case .success(let authors):
                self?.authorsSections = authors
            case .failure(let error):
                self?.showError?(error.localizedDescription)
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
