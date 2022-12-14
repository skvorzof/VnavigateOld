//
//  HomeDetailViewController.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 14.12.2022.
//

import UIKit

class HomeDetailViewController: UIViewController {

    let tempData = Author(
        name: "Клара Цеханасянц", profession: "дизайнер", avatar: "6", photos: [],
        posts: [
            Post(thumbnail: "cover", article: "Работаю пять дней в неделю. Встать в пять утра, сборы собаки, мужа, ребёнка. В семь уже бегу на транспорт. Домой приезжаю в восемь, готовка, уборка, спорт. Спать ложусь в полночь в лучшем случае. Спустя пару таких лет засыпаю постоянно, на работе вообще опен спейс. Как я ещё не сошла с ума? Я сплю в туалете на работе!P. S. Туалеты чистые, кабинок много на этаж, моют несколько раз в день.", isLike: true, like: 1, isFavorites: true)
        ])

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setSubviews(avatarImage, authorLabel, professionLabel, thumbnailImage, articleLabel, likeIcon, likeLabel, favoriteIcon)
        setConstraints()

        setupCell(with: tempData)
    }

    private func setSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
    }

    func setupCell(with post: Author) {
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
