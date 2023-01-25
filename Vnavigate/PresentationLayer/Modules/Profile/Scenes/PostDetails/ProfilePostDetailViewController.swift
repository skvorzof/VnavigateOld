//
//  ProfilePostDetailViewController.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 27.12.2022.
//

import UIKit

class ProfilePostDetailViewController: UIViewController {

    private let viewModel: ProfilePostDetailViewModel

    private let thumbnailImage = UIImageView()

    private let articleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private let likeIcon = UIImageView()
    private let likeLabel = UILabel()
    private let favoriteIcon = UIImageView()
    
    private lazy var tapFavoriteIcon = UITapGestureRecognizer(target: self, action: #selector(didTapFavoriteIcon))

    init(viewModel: ProfilePostDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setSubviews(thumbnailImage, articleLabel, likeIcon, likeLabel, favoriteIcon)
        setConstraints()
        setUI()
    }

    private func setUI() {
        favoriteIcon.addGestureRecognizer(tapFavoriteIcon)
        favoriteIcon.isUserInteractionEnabled = true
        
        thumbnailImage.image = UIImage(named: viewModel.post.thumbnail)
        articleLabel.text = viewModel.post.article

        if viewModel.post.isLike {
            likeIcon.image = UIImage(systemName: "heart.fill")
        } else {
            likeIcon.image = UIImage(systemName: "heart")
        }

        likeLabel.text = "\(viewModel.post.like)"

        if viewModel.post.isFavorites {
            favoriteIcon.image = UIImage(systemName: "bookmark.fill")
        } else {
            favoriteIcon.image = UIImage(systemName: "bookmark")
        }
    }

    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
    }
    
    @objc
    private func didTapFavoriteIcon() {
        CoreDataCoordinator.shared.savePostToFavorite(post: viewModel.post)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImage.heightAnchor.constraint(equalToConstant: 200),
            thumbnailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            thumbnailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            thumbnailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            articleLabel.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: 10),
            articleLabel.leadingAnchor.constraint(equalTo: thumbnailImage.leadingAnchor),
            articleLabel.trailingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor),

            likeIcon.widthAnchor.constraint(equalToConstant: 28),
            likeIcon.heightAnchor.constraint(equalToConstant: 28),
            likeIcon.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 7),
            likeIcon.leadingAnchor.constraint(equalTo: thumbnailImage.leadingAnchor),

            likeLabel.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 10),
            likeLabel.leadingAnchor.constraint(equalTo: likeIcon.trailingAnchor, constant: 7),

            favoriteIcon.widthAnchor.constraint(equalToConstant: 25),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 25),
            favoriteIcon.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 10),
            favoriteIcon.trailingAnchor.constraint(equalTo: thumbnailImage.trailingAnchor),
        ])
    }
}
