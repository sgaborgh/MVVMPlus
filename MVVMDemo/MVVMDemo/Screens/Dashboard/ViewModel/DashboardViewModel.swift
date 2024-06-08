//
//  DashboardViewModel.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation
import Combine

final class DashboardViewModel {

    
    // MARK: own enums

    enum Event {
        case viewDidLoad
    }

    enum ViewModelError: Error {
        case invalidCarListUrl
    }
    

    // MARK: properties

    private let apiManager: NetworkRequestManager
    private let router: DashboardRouterProtocol
    private let formatter: DashboardFormatterProtocol
    private let carListUrl: URL

    @Published private (set) var combineUIModel: DashboardUIModel // binding solution with Combine
    // private (set) var uiModel: Bind<DashboardUIModel> // own binding solution


    // MARK: life-cycle

    init(
        withRouter router: DashboardRouterProtocol,
        formatter: DashboardFormatterProtocol,
        carListUrlString: String,
        apiManager: NetworkRequestManager
    ) throws {
        guard let url = URL(string: carListUrlString) else {
            throw ViewModelError.invalidCarListUrl
        }

        self.router = router
        self.formatter = formatter
        self.carListUrl = url
        self.apiManager = apiManager
        self.combineUIModel = formatter.createUIModel(withCarList: [])
        // uiModel = .init(value: formatter.createUIModel(withCarList: []))
    }


    // MARK: event handling

    func handleEvent(_ event: Event) {
        switch event {
            case .viewDidLoad: 
                updateCarListInUIModel(fromUrl: carListUrl)
        }
    }


    // MARK: helpers

    func getCar(byBrand carBrand: String) -> Car? {
        combineUIModel.carList.first(where: { $0.brand == carBrand })
    }


    // MARK: private methods

    private func updateCarListInUIModel(fromUrl url: URL) {
        Task.detached(priority: .userInitiated) { [weak self] in
            guard let self = self else { return }

            do {
                let carList: [Car] = try await apiManager.request(url: url)
                self.combineUIModel = formatter.createUIModel(withCarList: carList)
                // self.uiModel.value = formatter.createUIModel(withCarList: carList)
            } catch (let error) {
                dump(error) // this should be handled in a real world app, uiModel could have information about what to display for the user about the error
            }
        }
    }

}
