//
//  AuthCoordinator.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 20.12.2022.
//

import UIKit

final class AuthCoordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let authViewController = AuthViewController(coordinator: self)
        authViewController.navigationItem.backButtonDisplayMode = .minimal
        navigationController.viewControllers = [authViewController]
    }

    func coordinateToRegister() {
        let registerViewController = RegisterViewController(coordinator: self)
        registerViewController.navigationItem.backButtonDisplayMode = .minimal
        navigationController.pushViewController(registerViewController, animated: true)
    }

    func coordinateToConfirmRegister() {
        let confirmRegisterViewController = ConfirmRegisterViewController(coordinator: self)
        navigationController.pushViewController(confirmRegisterViewController, animated: true)
    }

    func coordinateToLogin() {
        let loginViewController = LoginViewController(coordinator: self)
        loginViewController.navigationItem.backButtonDisplayMode = .minimal
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func coordinateToConfirmLogin() {
        let confirmLoginViewController = ConfirmLoginViewController(coordinator: self)
        navigationController.pushViewController(confirmLoginViewController, animated: true)
    }

    func coordinateToHomeFlow() {
        let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
        let rootViewController = UITabBarController()
        window?.rootViewController = rootViewController

        let tabCoordinator = TabCoordinator(tabBarController: rootViewController)
        tabCoordinator.start()
    }
}
