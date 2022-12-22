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

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        UITabBar.appearance().tintColor = CustomColor.orange
        UITabBar.appearance().unselectedItemTintColor = CustomColor.accent

        homeCoordinator.start()
        profileCoordinator.start()

        tabBarController.viewControllers = [
            profileCoordinator.navigationController,
            homeCoordinator.navigationController,
        ]
    }
}
