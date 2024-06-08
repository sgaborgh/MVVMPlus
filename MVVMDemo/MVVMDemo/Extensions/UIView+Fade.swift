//
//  UIView+Fade.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import UIKit

extension UIView {

    func fadeIn(
        withDuration duration: TimeInterval,
        delay: TimeInterval = 0.0,
        completion: Closure.BooleanValueReceived? = nil
    ) {
        alpha = 0
        UIView.animate(withDuration: duration, delay: delay, animations: { [weak self] in
            self?.alpha = 1
        }, completion: completion)
    }

    func fadeOut(
        withDuration duration: TimeInterval,
        delay: TimeInterval = 0.0,
        completion: Closure.BooleanValueReceived? = nil
    ) {
        alpha = 1
        UIView.animate(withDuration: duration, delay: delay, animations: { [weak self] in
            self?.alpha = 0
        }, completion: completion)
    }

}
