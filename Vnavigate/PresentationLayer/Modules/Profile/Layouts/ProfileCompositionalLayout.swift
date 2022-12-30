//
//  ProfileCompositionalLayout.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 24.12.2022.
//

import UIKit

final class ProfileCompositionalLayout: UICollectionViewCompositionalLayout {
    
    init(layoutTypeProvider: @escaping (Int) -> ProfileSection.LayoutType) {
        super.init(sectionProvider: { index, environment in
            return layoutTypeProvider(index).section(environment: environment)
        }, configuration: {
            return UICollectionViewCompositionalLayoutConfiguration()
        }())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileSection.LayoutType {
    
    func section(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch self {
        case .infoLayout:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(340)))
            item.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 20, leading: 0, bottom: 0, trailing: 0)
            return section
            
        case .photosLayout:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .estimated(70), heightDimension: .estimated(70)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            return section
            
        case .postsLayout:
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(350)))
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 20, leading: 16, bottom: 0, trailing: 16)
            return section
        }
    }
}
