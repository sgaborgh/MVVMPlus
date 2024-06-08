//
//  SplashAssembly.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import UIKit

final class SplashAssembly {

    static func createViewController(
        withNavigationController navigationController: UINavigationController
    ) throws -> SplashViewController {
        let formatter = SplashFormatter()
        let router = SplashRouter(withNavigationController: navigationController)
        let viewModel = try SplashViewModel(
            withRouter: router,
            formatter: formatter,
            possibleWelcomeTextList: Config.SplashScreen.possibleWelcomeTextList,
            showingScreenForSeconds: Config.SplashScreen.visibleForSeconds
        )
        let viewController = SplashViewController(
            viewModel: viewModel,
            fadeDuration: Config.SplashScreen.fadeDuration, 
            fadeOutDelay: Config.SplashScreen.fadeOutDelay,
            logoFileName: Config.SplashScreen.logoFileName
        )

        return viewController
    }

}
