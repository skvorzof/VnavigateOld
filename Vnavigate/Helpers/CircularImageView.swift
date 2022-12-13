//
//  CircularImageView.swift
//  Vnavigate
//
//  Created by Dima Skvortsov on 14.12.2022.
//

import UIKit

class CircularImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}
