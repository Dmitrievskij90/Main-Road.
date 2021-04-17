//
//  UIImageView+UIUtilites.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 11.04.2021.
//

import UIKit

extension UIImageView {
    func apllyImageViewCornerRadius(_ radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }

    func setImageShadowWithColor(color: CGColor?, opacity: Float?, offset: CGSize?, radius: CGFloat?, masksToBounds: Bool) {
        layer.shadowColor = color ?? UIColor.black.cgColor
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowRadius = radius ?? 1.0
        layer.masksToBounds = false
    }
}
