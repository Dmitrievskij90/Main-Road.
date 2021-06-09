//
//  UIImageView+UIUtilites.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 18.05.2021.
//

import UIKit

extension UIImageView {
    func apllyImageViewCornerRadius(_ radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }

    func setImageShadowWithColor() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity =  1.0
        layer.shadowRadius = 15.0
        layer.masksToBounds = false

//        layer.shadowColor = color ?? UIColor.black.cgColor
//        layer.shadowOffset = offset ?? CGSize.zero
//        layer.shadowOpacity = opacity ?? 1.0
//        layer.shadowRadius = radius ?? 1.0
//        layer.masksToBounds = false
    }
}
