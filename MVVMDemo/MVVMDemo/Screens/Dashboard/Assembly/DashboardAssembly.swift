//
//  DashboardAssembly.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import UIKit

final class DashboardAssembly {

    static func createViewController(
        withNavigationController navigationController: UINavigationController
    ) throws -> DashboardViewController {
        let formatter = DashboardFormatter()
        let router = DashboardRouter(withNavigationController: navigationController)
        let viewModel = try DashboardViewModel(
            withRouter: router,
            formatter: formatter,
            carListUrlString: Config.Api.carListUrlString,
            apiManager: ApiManager.shared
        )
        let viewController = DashboardViewController(viewModel: viewModel)

        return viewController
    }

}
