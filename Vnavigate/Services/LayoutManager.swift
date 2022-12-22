//
//  LayoutManager.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import UIKit

struct LayoutManager {

    static let shared = LayoutManager()

    private init() {}

    func createFriendSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .estimated(60), heightDimension: .estimated(60)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        return section
    }

    func createPostSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(410)))
        item.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 50, leading: 0, bottom: 0, trailing: 0)
        return section
    }

    func createProfileSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(410)))
        item.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 50, leading: 0, bottom: 0, trailing: 0)
        return section
    }
}
