//
//  BaseRouter.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import UIKit

class BaseRouter {

    weak var navigationController: UINavigationController?


    // MARK: life-cycle

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }


}
