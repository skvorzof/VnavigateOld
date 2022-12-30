//
//  FavoritesCompositionLayout.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 30.12.2022.
//

import UIKit

final class FavoritesCompositionLayout: UICollectionViewCompositionalLayout {
    
    init(layoutTypeProvider: @escaping (Int) -> FavoritesSection.LayoutType) {
        super.init(
            sectionProvider: { index, environment in
                let section = layoutTypeProvider(index).section(environment: environment)
                return section
            },
            configuration: {
                let configuration = UICollectionViewCompositionalLayoutConfiguration()
                return configuration
            }())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
