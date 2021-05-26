//
//  Coordinator.swift
//  BirthdayTracker
//
//  Created by REUTSKIY YURIY on 10.04.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import UIKit

/// Protocol for coordinator objects. Coordinator provides a transition between app's screen.
protocol Coordinator: AnyObject {

	/// Array of coordinators which can be opened inside the coorrdinator
	var childCoordinators: [String: Coordinator] { get set }

	/// Returns a start controller of flow. Can be UINavigationContrroller, UITabBarController.  Read-only property.
	var startController: UIViewController? { get }

	/// Open and display coordinator with starting point
	func start()

}

