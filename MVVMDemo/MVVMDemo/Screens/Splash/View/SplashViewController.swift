//
//  SplashViewController.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import UIKit
import Combine

final class SplashViewController: UIViewController {


    // MARK: constants

    struct Constants {
        static let logoSize: CGFloat = 50
        static let logoBottomPadding: CGFloat = 100

        static let springAnimationDuration: TimeInterval = 0.8
        static let springAnimationBounceValue: CGFloat = 0.4
        static let springAnimationLogoMoveDistance: CGFloat = 800
        static let springAnimationLabelMoveDistance: CGFloat = -800
    }


    // MARK: properties

    private let viewModel: SplashViewModel
    private let welcomeLabel: UILabel
    private let logoImage: UIImageView
    private let fadeDuration: TimeInterval
    private let fadeOutDelay: TimeInterval

    private var subscriptions: Array<AnyCancellable>


    // MARK: life-cycle

    init(viewModel: SplashViewModel, fadeDuration: TimeInterval, fadeOutDelay: TimeInterval, logoFileName: String) {
        self.viewModel = viewModel
        self.fadeDuration = fadeDuration
        self.fadeOutDelay = fadeOutDelay
        welcomeLabel = .init(frame: .infinite)
        logoImage = .init(image: .init(named: logoFileName))
        subscriptions = .init()

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModel()

        viewModel.handleEvent(.viewDidLoad)
    }


    // MARK: setup

    private func setupUI() {
        view.backgroundColor = .companyBlue

        welcomeLabel.alpha = 0
        welcomeLabel.font = .hugeTitle
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .primaryText
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        welcomeLabel.anchorToSafeAreaEdgesOfView(view)

        logoImage.alpha = 0
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImage)
        logoImage.addSizeConstraint(width: Constants.logoSize, height: Constants.logoSize)
        logoImage.anchorToSafeAreBottomCenterOfView(view, withBottomPadding: Constants.logoBottomPadding)
    }

    private func setupViewModel() {
        // combine as a binding system
        viewModel
            .$combineUIModel
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] newUIModel in
                guard let self = self else { return }

                welcomeLabel.text = newUIModel.welcomeLabelText
                runFadingAnimations(withDuration: fadeDuration, fadeOutDelay: fadeOutDelay)
            })
            .store(in: &subscriptions)

        // own binding system
        //        viewModel.uiModel.bindToValue { [weak self] newUIModel in
        //            guard let self = self,
        //                  let newUIModel = newUIModel else {
        //                return
        //            }
        //
        //            welcomeLabel.text = newUIModel.welcomeLabelText
        //            runFadingAnimations(withDuration: fadeDuration)
        //        }
    }

    private func runFadingAnimations(withDuration fadeDuration: TimeInterval, fadeOutDelay: TimeInterval) {
        logoImage.playHorizontalSpringAnimation(
            withSpringDuration: Constants.springAnimationDuration,
            bounce: Constants.springAnimationBounceValue,
            horizontalPixelMovement: Constants.springAnimationLogoMoveDistance
        )
        welcomeLabel.playHorizontalSpringAnimation(
            withSpringDuration: Constants.springAnimationDuration,
            bounce: Constants.springAnimationBounceValue,
            horizontalPixelMovement: Constants.springAnimationLabelMoveDistance
        )

        logoImage.fadeIn(withDuration: fadeDuration)
        welcomeLabel.fadeIn(withDuration: fadeDuration) { [weak self] _ in
            guard let self = self else { return }

            welcomeLabel.fadeOut(withDuration: fadeDuration, delay: fadeOutDelay)
            logoImage.fadeOut(withDuration: fadeDuration, delay: fadeOutDelay)
        }
    }

}
