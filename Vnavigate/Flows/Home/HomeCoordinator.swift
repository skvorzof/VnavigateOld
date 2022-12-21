//
//  HomeCoordinator.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 20.12.2022.
//

import UIKit

final class HomeCoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = HomeViewModel()
        let homeViewController = HomeViewController(coordinator: self, viewModel: viewModel)
        homeViewController.title = "Главная"
        navigationController.viewControllers = [homeViewController]
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))
    }
    
    func coordinateToHomePostDetail(author: Author) {
        let homePostDetailViewController = HomePostDetailViewController(author: author)
        navigationController.pushViewController(homePostDetailViewController, animated: true)
    }
    
    func coordinateToHomeAuthorProfile(author: Author) {
        print("coordinateToHomeAuthorProfile ->")
    }
}

