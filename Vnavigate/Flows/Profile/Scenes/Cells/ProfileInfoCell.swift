//
//  ProfileInfoCell.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 22.12.2022.
//

import UIKit

class ProfileInfoCell: UICollectionViewCell {

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        setSubviews(avatarImage, authorLabel, professionLabel, thumbnailImage, articleLabel, likeIcon, likeLabel, favoriteIcon)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
    }

    func setupCell(with post: Author) {
        avatarImage.image = UIImage(named: post.avatar)
        authorLabel.text = post.name
        professionLabel.text = post.profession

        for item in post.posts {
            thumbnailImage.image = UIImage(named: item.thumbnail)
            articleLabel.text = item.article.limitedText(to: 120)

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

    private func setConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            avatarImage.topAnchor.constraint(equalTo: topAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor),

            authorLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 7),
            authorLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),

            professionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            professionLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),

            thumbnailImage.heightAnchor.constraint(equalToConstant: 200),
            thumbnailImage.topAnchor.constraint(equalTo: professionLabel.bottomAnchor, constant: 20),
            thumbnailImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImage.trailingAnchor.constraint(equalTo: trailingAnchor),

            articleLabel.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: 10),
            articleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            likeIcon.widthAnchor.constraint(equalToConstant: 28),
            likeIcon.heightAnchor.constraint(equalToConstant: 28),
            likeIcon.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 7),
            likeIcon.leadingAnchor.constraint(equalTo: leadingAnchor),

            likeLabel.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 10),
            likeLabel.leadingAnchor.constraint(equalTo: likeIcon.trailingAnchor, constant: 7),

            favoriteIcon.widthAnchor.constraint(equalToConstant: 25),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 25),
            favoriteIcon.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 10),
            favoriteIcon.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
