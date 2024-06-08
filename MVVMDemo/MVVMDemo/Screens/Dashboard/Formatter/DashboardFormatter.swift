//
//  DashboardFormatter.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation


// MARK: interface

protocol DashboardFormatterProtocol {

    func createUIModel(withCarList carList: [Car]) -> DashboardUIModel
    
}


// MARK: formatter

final class DashboardFormatter: DashboardFormatterProtocol {

    func createUIModel(withCarList carList: [Car]) -> DashboardUIModel {
        .init(carList: carList)
    }

}
