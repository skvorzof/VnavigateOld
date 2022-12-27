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
        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(coordinator: self, viewModel: profileViewModel)
        profileViewController.title = "Профиль"
        navigationController.viewControllers = [profileViewController]
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))
    }

    func coordinateToProfileSettings() {
        let profileSettingsViewController = ProfileSettingsViewController()
        profileSettingsViewController.title = "Настройки"

        if let sheet = profileSettingsViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        navigationController.present(profileSettingsViewController, animated: true)
    }

    func coordinateToProfilePhotos() {
        let profilePhotosViewModel = ProfilePhotosViewModel()
        let profilePhotosViewContoller = ProfilePhotosViewContoller(coordinator: self, viewModel: profilePhotosViewModel)
        profilePhotosViewContoller.title = "Фотографии"
        navigationController.pushViewController(profilePhotosViewContoller, animated: true)
    }

    func coordinateToPhotosDetails(photo: Photo) {
        let profilePhotosDetailViewModel = ProfilePhotosDetailViewModel(photo: photo)
        let profilePhotosDetailViewController = ProfilePhotosDetailViewController(viewModel: profilePhotosDetailViewModel)
        navigationController.present(profilePhotosDetailViewController, animated: true)
    }
    
    func coordinateToPostDetails(post: Post) {
        let profilePostDetailViewModel = ProfilePostDetailViewModel(post: post)
        let profilePostDetailViewController = ProfilePostDetailViewController(viewModel: profilePostDetailViewModel)
        navigationController.pushViewController(profilePostDetailViewController, animated: true)
    }
}
