//
//  FriendCell.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 13.12.2022.
//

import UIKit

class FriendCell: UICollectionViewCell {

    static let reuseId = "FriendCell"
    
    private let avatarImage = CircularImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        setSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setSubviews() {
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarImage)
    }

    func setupCell(with author: Author) {
        avatarImage.image = UIImage(named: author.avatar)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
