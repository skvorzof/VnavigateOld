//
//  HomeFriendCell.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 13.12.2022.
//

import UIKit

class HomeFriendCell: UICollectionViewCell {

    private let avatarImage = CircularImageView()

    var viewModel: HomeFriendCellViewModel? {
        didSet {
            avatarImage.image = UIImage(named: viewModel?.avatarImage ?? "")
        }
    }

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

    private func setConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
