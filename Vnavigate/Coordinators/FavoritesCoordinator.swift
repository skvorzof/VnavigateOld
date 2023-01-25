//
//  FavoritesCoordinator.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 30.12.2022.
//

import UIKit

final class FavoritesCoordinator {
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let favoritesViewModel = FavoritesViewModel()
        let favoritesViewController = FavoritesViewController(coordinator: self, viewModel: favoritesViewModel)
        favoritesViewController.title = "Избранное"
        navigationController.viewControllers = [favoritesViewController]
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill"))
    }
    
    func coordinateToFavoritesDetails(post: Favorite) {
        let favoritesDetailsViewModel = FavoritesDetailsViewModel(post: post)
        let favoritesDetailsViewController = FavoritesDetailsViewController(coordinator: self, viewModel: favoritesDetailsViewModel)
        navigationController.pushViewController(favoritesDetailsViewController, animated: true)
    }
    
    func coordinateToFavorites() {
        navigationController.popViewController(animated: true)
    }
}
