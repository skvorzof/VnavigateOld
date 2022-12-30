//
//  TabCoordinator.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 20.12.2022.
//

import UIKit

final class TabCoordinator {

    private let tabBarController: UITabBarController
    private let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
    private let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
    private let favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController())

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        tabBarController.tabBar.tintColor = CustomColor.orange
        tabBarController.tabBar.unselectedItemTintColor = CustomColor.accent

        homeCoordinator.start()
        profileCoordinator.start()
        favoritesCoordinator.start()

        tabBarController.viewControllers = [
            favoritesCoordinator.navigationController,
            homeCoordinator.navigationController,
            profileCoordinator.navigationController,
        ]
    }
}
