//
//  Typealiases.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import UIKit

typealias HomeLisDiffableDataSource = UICollectionViewDiffableDataSource<HomeSection, HomeSection.Item>
typealias HomeListDiffableSnapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeSection.Item>

typealias ProfileDiffableDataSource = UICollectionViewDiffableDataSource<ProfileSection, ProfileSection.Item>
typealias ProfileDiffableSnapshot = NSDiffableDataSourceSnapshot<ProfileSection, ProfileSection.Item>

typealias FavoritesDiffableDataSource = UICollectionViewDiffableDataSource<FavoritesSection, FavoritesSection.Item>
typealias FavoritesDiffableSnapshot = NSDiffableDataSourceSnapshot<FavoritesSection, FavoritesSection.Item>
