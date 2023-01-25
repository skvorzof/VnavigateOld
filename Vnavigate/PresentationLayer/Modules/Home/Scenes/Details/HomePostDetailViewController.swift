//
//  HomePostDetailViewController.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import UIKit

class HomePostDetailViewController: UIViewController {

    private let author: Author

    private let avatarImage = CircularImageView()
    private let authorLabel = UILabel()
    private let professionLabel = UILabel()
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

    init(author: Author) {
        self.author = author
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setSubviews(avatarImage, authorLabel, professionLabel, thumbnailImage, articleLabel, likeIcon, likeLabel, favoriteIcon)
        setConstraints()

        setupModel(with: author)
    }

    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
    }

    func setupModel(with post: Author) {
        favoriteIcon.addGestureRecognizer(tapFavoriteIcon)
        favoriteIcon.isUserInteractionEnabled = true
        
        avatarImage.image = UIImage(named: post.avatar)
        authorLabel.text = post.name
        professionLabel.text = post.profession

        for item in post.posts {
            thumbnailImage.image = UIImage(named: item.thumbnail)
            articleLabel.text = item.article

            if item.isLike {
                likeIcon.image = UIImage(systemName: "heart.fill")
            } else {
                likeIcon.image = UIImage(systemName: "heart")
            }

            likeLabel.text = "\(item.like)"

            if item.isFavorites {
                favoriteIcon.image = UIImage(systemName: "bookmark.fill")
            } else {
                favoriteIcon.image = UIImage(systemName: "bookmark")
            }
        }
    }
    
    @objc
    private func didTapFavoriteIcon() {
        author.posts.forEach { post in

            let post = Post(
                thumbnail: post.thumbnail,
                article: post.article,
                isLike: post.isLike,
                like: post.like,
                isFavorites: !post.isFavorites)
            
            CoreDataCoordinator.shared.savePostToFavorite(post: post)
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            authorLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 7),
            authorLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),

            professionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            professionLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),

            thumbnailImage.heightAnchor.constraint(equalToConstant: 200),
            thumbnailImage.topAnchor.constraint(equalTo: professionLabel.bottomAnchor, constant: 20),
            thumbnailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            thumbnailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            articleLabel.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: 10),
            articleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            articleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            likeIcon.widthAnchor.constraint(equalToConstant: 28),
            likeIcon.heightAnchor.constraint(equalToConstant: 28),
            likeIcon.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 7),
            likeIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            likeLabel.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 10),
            likeLabel.leadingAnchor.constraint(equalTo: likeIcon.trailingAnchor, constant: 7),

            favoriteIcon.widthAnchor.constraint(equalToConstant: 25),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 25),
            favoriteIcon.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 10),
            favoriteIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
