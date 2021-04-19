//
//  ListDisplayModel.swift
//  BirthdayTracker
//
//  Created by REUTSKIY YURIY on 14.08.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import Foundation

struct DateDisplayModel {
	let date: String

	init(date: Date?) {
		guard let date = date else {
			self.date = "N/A"
			return
		}
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .medium
		let dateString = dateFormatter.string(from: date)
		self.date = dateString
	}
}
