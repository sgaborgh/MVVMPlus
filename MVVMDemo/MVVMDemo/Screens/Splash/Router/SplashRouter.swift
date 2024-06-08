//
//  SplashRouter.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation


// MARK: interface

protocol SplashRouterProtocol {

    func navigateToDashboard()

}


// MARK: router

final class SplashRouter: BaseRouter, SplashRouterProtocol {


    // MARK: router protocol

    func navigateToDashboard() {
        guard let navigationController = navigationController,
              let viewController = try? DashboardAssembly.createViewController(withNavigationController: navigationController) else {
            return
        }

        navigationController.pushViewController(viewController, animated: true)
    }

}
