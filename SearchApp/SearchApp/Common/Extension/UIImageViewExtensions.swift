//
//  UIImageViewExtensions.swift
//  SearchApp
//
//  Created by 이아연 on 2021/07/12.
//

import UIKit

extension UIImageView {
    
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask? = nil) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        
        if let corners = maskedCorners {
            layer.maskedCorners = CACornerMask(arrayLiteral: corners)
        }
    }
}

