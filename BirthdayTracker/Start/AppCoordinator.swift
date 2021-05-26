//
//  AppCoordinator.swift
//  BirthdayTracker
//
//  Created by REUTSKIY YURIY on 10.04.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import UIKit

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
	}

	private func setup() {
		let profileCoordinator = ProfileCoordinator()
		childCoordinators[Childs.profile.rawValue] = profileCoordinator

		let birthdayListCoordinator = BirthdayListCoordinator()
		childCoordinators[Childs.birthdayList.rawValue] = birthdayListCoordinator
	}
}
