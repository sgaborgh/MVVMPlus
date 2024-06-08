//
//  SplashViewModel.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation
import Combine

final class SplashViewModel {


    // MARK: own enums

    enum Event {
        case viewDidLoad
    }

    enum ViewModelError: Error {
        case emptyWelcomeTextList
    }


    // MARK: properties

    private let router: SplashRouterProtocol
    private let formatter: SplashFormatterProtocol
    private let possibleWelcomeTextList: [String]
    private let showingScreenForSeconds: TimeInterval

    @Published private (set) var combineUIModel: SplashUIModel // binding solution with Combine
    // private (set) var uiModel: Bind<SplashUIModel> // own binding solution


    // MARK: life-cycle

    init(
        withRouter router: SplashRouterProtocol,
        formatter: SplashFormatterProtocol,
        possibleWelcomeTextList: [String],
        showingScreenForSeconds: TimeInterval
    ) throws {
        guard !possibleWelcomeTextList.isEmpty else {
            throw ViewModelError.emptyWelcomeTextList
        }

        self.router = router
        self.formatter = formatter
        self.possibleWelcomeTextList = possibleWelcomeTextList
        self.showingScreenForSeconds = showingScreenForSeconds
        combineUIModel = formatter.createUIModel(withText: "")
        // uiModel = .init(value: formatter.createUIModel(withText: ""))
    }


    // MARK: event handling

    func handleEvent(_ event: Event) {
        switch event {
            case .viewDidLoad:
                guard let labelText = getNewLabelText(fromList: possibleWelcomeTextList) else { return }
                combineUIModel = formatter.createUIModel(withText: labelText)
                // uiModel.value = formatter.createUIModel(withText: labelText)

                navigateToDashboardScreen(afterSeconds: showingScreenForSeconds)
        }
    }


    // MARK: private methods

    private func getNewLabelText(fromList textList: [String]) -> String? {
        textList.randomElement()
    }

    private func navigateToDashboardScreen(afterSeconds: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + afterSeconds, execute: { [weak self] in
            guard let self = self else { return }

            self.router.navigateToDashboard()
        })
    }

}
