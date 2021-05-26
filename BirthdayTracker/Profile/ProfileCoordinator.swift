//
//  ProfileCoordinator.swift
//  BirthdayTracker
//
//  Created by Reutskiy Yura on 06.05.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import UIKit

///// Коммуникация между flow coordinator
//protocol ProfileIO: AnyObject {
//    var addNewDateCallback: DateCallback { get set }
//}

class ProfileCoordinator: Coordinator /*, ProfileIO*/ {
    var childCoordinators: [String: Coordinator] = [:]

    private(set) var startController: UIViewController?

//    var addNewDateCallback: DateCallback = { _ in }

    func start() {
        let viewModel = ProfileViewModel()
        let profileVC = ProfileViewController(viewModel: viewModel)
        startController = UINavigationController(rootViewController: profileVC)
    }
}
