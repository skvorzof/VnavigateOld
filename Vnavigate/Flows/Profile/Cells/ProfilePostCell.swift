//
//  ProfilePostCell.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 24.12.2022.
//

import UIKit

class ProfilePostCell: UICollectionViewCell {

    private let thumbnailImage = UIImageView()

    private let articleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private let likeIcon = UIImageView()
    private let likeLabel = UILabel()
    private let favoriteIcon = UIImageView()

    var viewModel: ProfilePostCellViewModel? {
        didSet {
            thumbnailImage.image = UIImage(named: viewModel?.thumbnail ?? "plus")
            articleLabel.text = viewModel?.article.limitedText(to: 120)

            if let isLike = viewModel?.isLike {
                if isLike {
                    likeIcon.image = UIImage(systemName: "heart.fill")
                } else {
                    likeIcon.image = UIImage(systemName: "heart")
                }
            }

            if let like = viewModel?.like {
                likeLabel.text = "\(like)"
            }

            if let isFavorites = viewModel?.isFavorites {
                if isFavorites {
                    favoriteIcon.image = UIImage(systemName: "bookmark.fill")
                } else {
                    favoriteIcon.image = UIImage(systemName: "bookmark")
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        setSubviews(thumbnailImage, articleLabel, likeIcon, likeLabel, favoriteIcon)
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



    private func setConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImage.heightAnchor.constraint(equalToConstant: 200),
            thumbnailImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
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
