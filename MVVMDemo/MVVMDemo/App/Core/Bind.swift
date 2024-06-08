//
//  Bind.swift
//  MVVMDemo
//
//  Created by Gabor Saliga on 01/06/2024.
//

import Foundation

// not actually used in this demo, Combine is used instead, but I left it here for demonstration purposes
final class Bind<T> {

    typealias BindClosure = (T?) -> Void

    var value: T? {
        didSet {
            closures.forEach({ closure in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    closure(value)
                }
            })
        }
    }
    private var closures: [BindClosure] = []

    init(value: T?) {
        self.value = value
    }

    func bindToValue(_ closure: @escaping BindClosure) {
        closures.append(closure)
    }

}
