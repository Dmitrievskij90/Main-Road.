//
//  UIView+UIUtilites.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 18.05.2021.
//

import UIKit

extension UIView {
    func apllyViewCornerRadius(_ radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }

    func setViewShadowWithColor(color: CGColor?, opacity: Float?, offset: CGSize?, radius: CGFloat?, masksToBounds: Bool) {
        layer.shadowColor = color ?? UIColor.black.cgColor
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowRadius = radius ?? 1.0
        layer.masksToBounds = false
    }
}
