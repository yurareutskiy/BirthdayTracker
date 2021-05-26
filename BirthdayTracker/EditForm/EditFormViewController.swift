//
//  EditFormViewController.swift
//  BirthdayTracker
//
//  Created by Reutskiy Yura on 08.05.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import UIKit
import SwiftUI

class EditFormViewController: UIViewController {
    
    let viewModel: EditFormViewModel
    
    init(viewModel: EditFormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("We don't use Inteface builder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        var formView = EditFormView(model: viewModel)
        formView.closeAction = { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        }
        let vc = UIHostingController(rootView: formView)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: view.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.close()
    }
}
