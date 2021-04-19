//
//  ProfileViewController.swift
//  BirthdayTracker
//
//  Created by REUTSKIY YURIY on 07.07.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import UIKit

protocol ProfileViewModelProtocol {

}

class ProfileViewModel: ProfileViewModelProtocol {

	var addNewDateAction: DateCallback = { _ in }

	var buttonTapped: VoidCallback?

	init() {
		self.buttonTapped = {
			let date = Date()
			self.addNewDateAction(date)
		}
	}
}

class ProfileViewController: UIViewController {

	var viewModel: ProfileViewModel

	lazy var button: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		NSLayoutConstraint.activate([
			button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			button.widthAnchor.constraint(equalToConstant: 200.0),
			button.heightAnchor.constraint(equalToConstant: 80.0),
		])
		button.backgroundColor = .secondarySystemBackground
		button.isOpaque = false
		button.setTitle("Add a date into list", for: .normal)
		button.setTitleColor(.secondaryLabel, for: .normal)
		button.layer.cornerRadius = 20.0

		return button
	}()

	init(viewModel: ProfileViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		title = "Профиль"
		navigationController?.navigationBar.prefersLargeTitles = true
	}

	required init?(coder: NSCoder) {
		fatalError("We don't use Inteface builder")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}

	@objc func buttonTapped() {
		viewModel.buttonTapped?()
	}

}
