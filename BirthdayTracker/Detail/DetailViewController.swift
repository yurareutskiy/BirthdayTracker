//
//  DetailViewController.swift
//  BirthdayTracker
//
//  Created by REUTSKIY YURIY on 19.04.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	let viewModel: DetailViewModel

	init(viewModel: DetailViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		title = "Date"
		view.backgroundColor = .systemBackground
		setupLabel()
	}

	private func setupLabel() {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.textColor = .label
		label.numberOfLines = 0
		label.textAlignment = .center
		view.addSubview(label)
		NSLayoutConstraint.activate([
			label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20.0)
		])
		label.text = viewModel.formattedDate
	}

}
