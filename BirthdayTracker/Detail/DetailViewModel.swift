//
//  DetailViewModel.swift
//  BirthdayTracker
//
//  Created by REUTSKIY YURIY on 19.04.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import Foundation

class DetailViewModel {

	let date: Date

	init(date: Date) {
		self.date = date
	}

	var formattedDate: String {
		let formatter = DateFormatter()
		formatter.dateStyle = .full
		formatter.timeStyle = .full

		let string = "Date: \(formatter.string(from: date))"
		return string
	}
}
