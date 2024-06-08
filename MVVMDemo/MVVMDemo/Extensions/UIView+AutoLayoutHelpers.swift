//
//  UIView+AutoLayoutHelpers.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 02/06/2024.
//

import UIKit

extension UIView {

    func anchorToSafeAreaEdgesOfView(
        _ view: UIView,
        withPadding padding: CGFloat = 0
    ) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: padding),
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: padding)
        ])
    }

    func anchorToSafeAreBottomCenterOfView(
        _ view: UIView,
        withBottomPadding bottomPadding: CGFloat = 0
    ) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomPadding)
        ])
    }

    func addSizeConstraint(width: CGFloat? = nil, height: CGFloat? = nil) {
        if let width = width {
            NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: width)])
        }
        if let height = height {
            NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: height)])
        }
    }

}
