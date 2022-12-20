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

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        UITabBar.appearance().tintColor = CustomColor.orange

        homeCoordinator.start()

        tabBarController.viewControllers = [
            homeCoordinator.navigationController
        ]
    }
}
