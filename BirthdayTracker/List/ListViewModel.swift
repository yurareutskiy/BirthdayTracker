//
//  ListViewModel.swift
//  BirthdayTracker
//
//  Created by REUTSKIY YURIY on 14.08.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import Foundation

enum ListError: Error {
	case invalidIndexPath
	case objectIsNotExistedForIndex
}

class ListViewModel {

	var dates: [Date] = []

	var updateHandler: VoidCallback = {}

	var showDetailViewHandler: ((Date) -> Void) = { _ in }

	func rowDidSelect(with index: Int) throws {
		guard index < self.dates.count else {
			throw ListError.objectIsNotExistedForIndex
		}
		let object = self.dates[index]
		self.showDetailViewHandler(object)
	}

	func add(date: Date) {
		dates.append(date)
		updateHandler()
	}

	func date(for index: Int) throws -> DateDisplayModel {
		guard index < dates.count else {
			throw ListError.invalidIndexPath
		}
		let date = DateDisplayModel(date: dates[index])
		return date
	}

}
