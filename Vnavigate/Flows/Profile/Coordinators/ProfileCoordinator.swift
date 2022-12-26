//
//  ProfileCoordinator.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import UIKit

final class ProfileCoordinator {
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(coordinator: self, viewModel: viewModel)
        profileViewController.title = "Профиль"
        navigationController.viewControllers = [profileViewController]
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))
    }
    
    func coordinateToProfilePhotos() {
        let profilePhotosViewContoller = ProfilePhotosViewContoller()
        profilePhotosViewContoller.title = "Фотографии"
        navigationController.pushViewController(profilePhotosViewContoller, animated: true)
    }
    
    func coordinateToProfileSettings() {
        let profileSettingsViewController = ProfileSettingsViewController()
        profileSettingsViewController.title = "Настройки"
        navigationController.pushViewController(profileSettingsViewController, animated: true)
    }
}
