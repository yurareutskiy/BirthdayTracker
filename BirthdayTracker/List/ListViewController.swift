//
//  ListViewController.swift
//  BirthdayTracker
//
//  Created by REUTSKIY YURIY on 07.07.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import UIKit
import Combine


class ListViewController: UIViewController {

	var viewModel: ListViewModel

	init(viewModel: ListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("We don't use Inteface builder")
	}

	private enum Constants {
		static let cellIdentifier = "ListViewControllerCell"
	}

	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(ListTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
		return tableView
	}()


	override func viewDidLoad() {
		super.viewDidLoad()
		title = "List"
        setupAddButton()
		navigationController?.navigationBar.prefersLargeTitles = true
		setupTableView()
		viewModel.updateHandler = { [weak self] in
			self?.tableView.reloadData()
		}
	}

    private func setupAddButton() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add,
                                      target: self,
                                      action: #selector(addItemAction))
        addItem.tintColor = .darkText
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc private func addItemAction() {
        let addNewItemVC = EditFormFabric.configureAddNewController(completion: viewModel.addNewBirthday)
        addNewItemVC.modalPresentationStyle = .formSheet
        present(addNewItemVC, animated: true, completion: nil)
    }
    
	private func setupTableView() {
		view.addSubview(tableView)

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
		])
	}
}

extension ListViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		do {
			try viewModel.rowDidSelect(with: indexPath.row)
		} catch ListError.objectIsNotExistedForIndex {
			fatalError("Invalid index path; Requested object is not existed with such index;")
		} catch {
			print("Unexpected error in display model requesting")
		}
	}

}

extension ListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.dates.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? ListTableViewCell else {
			return UITableViewCell()
		}
		do {
			let displayModel = try viewModel.date(for: indexPath.row)
			cell.textLabel?.text = displayModel.date
		} catch ListError.invalidIndexPath {
			fatalError("Invalid index path; Requested element is not existed with such index;")
		} catch {
			print("Unexpected error in display model requesting")
		}
		return cell
	}
}
