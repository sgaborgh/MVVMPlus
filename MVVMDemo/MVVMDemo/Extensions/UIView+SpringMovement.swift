//
//  UIView+SpringMovement.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 07/06/2024.
//

import UIKit

extension UIView {

    func playHorizontalSpringAnimation(
        withSpringDuration duration: TimeInterval = 0.5,
        bounce: CGFloat = 0.0,
        horizontalPixelMovement: CGFloat = 0
    ) {
        UIView.animate(springDuration: duration, bounce: bounce) {
            self.center.x += horizontalPixelMovement
        }
    }

}
