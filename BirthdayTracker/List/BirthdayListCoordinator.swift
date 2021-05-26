//
//  BirthdayListCoordinator.swift
//  BirthdayTracker
//
//  Created by Reutskiy Yura on 06.05.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import UIKit

///// Коммуникация между flow coordinator
class BirthdayListCoordinator: Coordinator /*, BirthdayListIO*/ {

    var childCoordinators: [String: Coordinator] = [:]

    private(set) var startController: UIViewController?
    private let viewModel = ListViewModel()

    func start() {
        // бизнес логика должна быть инкапсулирована внутри экрана
        viewModel.showDetailViewHandler = openDetail
        startController = UINavigationController(rootViewController: ListViewController(viewModel: viewModel))
    }

    // MARK: -- BirthdayListIO
    func add(date: Date) {
        viewModel.add(date: date)
    }

    func openDetail(with object: Date) {
        let viewModel = DetailViewModel(date: object)
        let viewController = DetailViewController(viewModel: viewModel)
        if let navigationController = startController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
