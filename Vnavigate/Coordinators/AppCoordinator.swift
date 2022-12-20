//
//  AppCoordinator.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 20.12.2022.
//

import UIKit

final class AppCoordinator {

    private var isAutorized = true
    private var rootViewController: UIViewController?
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        if isAutorized {
            homeFlow()
        } else {
            authFlow()
        }
    }

    func authFlow() {
        rootViewController = UINavigationController()
        window.rootViewController = rootViewController

        if let rootViewController = rootViewController as? UINavigationController {
            let authCoordinator = AuthCoordinator(navigationController: rootViewController)
            authCoordinator.start()
        }
    }

    func homeFlow() {
        rootViewController = UITabBarController()
        window.rootViewController = rootViewController

        if let rootViewController = rootViewController as? UITabBarController {
            let tabCoordinator = TabCoordinator(tabBarController: rootViewController)
            tabCoordinator.start()
        }
    }
}
