//
//  DashboardViewController.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import UIKit
import Combine

final class DashboardViewController: UIViewController {

    
    // MARK: own enums

    enum SectionType: Hashable {
        case firstBasicSection
    }


    // MARK: properties

    private let loadingSpinner: UIActivityIndicatorView
    private let viewModel: DashboardViewModel
    private let tableView: UITableView

    private var dataSource: UITableViewDiffableDataSource<SectionType, String>!
    private var subscriptions: Array<AnyCancellable>


    // MARK: life-cycle

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        tableView = .init()
        loadingSpinner = .init(style: .medium)
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
        title = "Project Dashboard".localized
        navigationItem.setHidesBackButton(true, animated: false)

        view.backgroundColor = .companyBlue

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .opaqueSeparator
        view.addSubview(tableView)
        tableView.anchorToSafeAreaEdgesOfView(view)

        loadingSpinner.color = .primaryText
        tableView.backgroundView = loadingSpinner
        changeLoadingSpinnerVisibility(toHidden: false)

        dataSource = .init(tableView: tableView, cellProvider: getCell)
    }

    private func setupViewModel() {
        // combine as a binding system
        viewModel
            .$combineUIModel
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] newUIModel in
                guard let self = self,
                      !newUIModel.carList.isEmpty else {
                    return
                }

                changeLoadingSpinnerVisibility(toHidden: true)
                generateSnapshotForTableView(byCarList: newUIModel.carList)
            })
            .store(in: &subscriptions)

        // own binding system
        //        viewModel.uiModel.bindToValue { [weak self] newUIModel in
        //            guard let self = self,
        //                  let newUIModel = newUIModel,
        //                  !newUIModel.carList.isEmpty else {
        //                return
        //            }
        //
        //            changeLoadingSpinnerVisibility(toHidden: true)
        //            generateSnapshotForTableView(byCarList: newUIModel.carList)
        //        }
    }

    private func changeLoadingSpinnerVisibility(toHidden isHidden: Bool) {
        if isHidden {
            loadingSpinner.stopAnimating()
            loadingSpinner.isHidden = true
        } else {
            loadingSpinner.startAnimating()
            loadingSpinner.isHidden = false
        }
    }


    // MARK: table view cell management

    private func generateSnapshotForTableView(byCarList carList: [Car]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, String>()
        snapshot.appendSections([.firstBasicSection])
        snapshot.appendItems(carList.map({ $0.brand }), toSection: .firstBasicSection)
        dataSource.apply(snapshot)
    }

    private func getCell(tableView: UITableView, indexPath: IndexPath, itemIdentifier brand: String) -> UITableViewCell? {
        guard let car = viewModel.getCar(byBrand: brand) else { return nil }

        let cell: UITableViewCell = .init(style: .subtitle, reuseIdentifier: "cell_\(indexPath.row)")
        let title: String = car.brand
        let subTitle: String = car.models.joined(separator: ", ")

        cell.selectionStyle = .none
        cell.backgroundColor = .companyBlue
        cell.textLabel?.font = .regular
        cell.textLabel?.text = title
        cell.textLabel?.textColor = .primaryText
        cell.detailTextLabel?.font = .small
        cell.detailTextLabel?.text = subTitle
        cell.detailTextLabel?.textColor = .secondaryText

        return cell
    }

}
