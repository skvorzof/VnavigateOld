//
//  ProfilePhotosDetailViewController.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 27.12.2022.
//

import UIKit

class ProfilePhotosDetailViewController: UIViewController {

    private let viewModel: ProfilePhotosDetailViewModel

    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    init(viewModel: ProfilePhotosDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    private func setUI() {
        view.backgroundColor = .black
        view.addSubview(photoView)

        photoView.image = UIImage(named: viewModel.photo.photo)

        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: view.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
