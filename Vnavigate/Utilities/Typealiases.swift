//
//  Typealiases.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import UIKit

typealias AuthorsLisDiffableDataSource = UICollectionViewDiffableDataSource<AuthorsSections, Author>
typealias AuthorsListDiffableSnapshot = NSDiffableDataSourceSnapshot<AuthorsSections, Author>

typealias ProfileDiffableDataSource = UICollectionViewDiffableDataSource<ProfileSection, ProfileSection.Item>
typealias ProfileDiffableSnapshot = NSDiffableDataSourceSnapshot<ProfileSection, ProfileSection.Item>

typealias FavoritesDiffableDataSource = UICollectionViewDiffableDataSource<FavoritesSection, FavoritesSection.Item>
typealias FavoritesDiffableSnapshot = NSDiffableDataSourceSnapshot<FavoritesSection, FavoritesSection.Item>
