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
