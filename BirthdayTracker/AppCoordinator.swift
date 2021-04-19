//
//  AppCoordinator.swift
//  BirthdayTracker
//
//  Created by REUTSKIY YURIY on 10.04.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import UIKit

///// Коммуникация между flow coordinator
//protocol ProfileIO: AnyObject {
//	var addNewDateCallback: DateCallback { get set }
//}

class ProfileCoordinator: Coordinator /*, ProfileIO*/ {
	var childCoordinators: [String: Coordinator] = [:]

	private(set) var startController: UIViewController?

	var addNewDateCallback: DateCallback = { _ in }

	func start() {
		let viewModel = ProfileViewModel()

		viewModel.addNewDateAction = { [weak self] date in
			self?.addNewDateCallback(date)
		}
		startController = UINavigationController(rootViewController: ProfileViewController(viewModel: viewModel))
	}
}

///// Коммуникация между flow coordinator
//protocol BirthdayListIO: AnyObject {
//
//	func add(date: Date)
//}

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



/// Start point for the app
class AppCoordinator: Coordinator {

	private enum Childs: String, CaseIterable {
		case birthdayList
		case profile
	}

	var childCoordinators: [String: Coordinator] = [:]

	private(set) var startController: UIViewController?

	init() {
		setup()
	}

	func start() {
		let appTabBarController = UITabBarController()
		startController = appTabBarController

		let controllers: [UIViewController] = Childs
			.allCases
			.map({ childCoordinators[$0.rawValue] })
			.compactMap({ coordinator in
				coordinator?.start()
				return coordinator?.startController
			})

		appTabBarController.viewControllers = controllers

		setupBindings()
	}

	private func setup() {
		let profileCoordinator = ProfileCoordinator()
		childCoordinators[Childs.profile.rawValue] = profileCoordinator

		let birthdayListCoordinator = BirthdayListCoordinator()
		childCoordinators[Childs.birthdayList.rawValue] = birthdayListCoordinator
	}

	private func setupBindings() {
		let profileIO = childCoordinators[Childs.profile.rawValue] as? ProfileCoordinator
		let birthdayIO = childCoordinators[Childs.birthdayList.rawValue] as? BirthdayListCoordinator

		profileIO?.addNewDateCallback = { [weak birthdayIO] date in
			birthdayIO?.add(date: date)
		}
	}
}
