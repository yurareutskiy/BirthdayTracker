//
//  EditFormFabric.swift
//  BirthdayTracker
//
//  Created by Reutskiy Yura on 26.05.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import UIKit

class EditFormFabric {
    static func configureAddNewController(completion: BirthdayCallback?) -> UIViewController {
        let viewModel = EditFormViewModel(editType: .addNew, completion: completion)
        let vc = EditFormViewController(viewModel: viewModel)
        let nc = UINavigationController(rootViewController: vc)
        return nc
    }
}
