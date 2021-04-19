//
//  BirthdayManager.swift
//  BirthdayTracker
//
//  Created by REUTSKIY YURIY on 14.08.2020.
//  Copyright © 2020 REUTSKIY YURIY. All rights reserved.
//

import Foundation

enum BirthdayError: Error {
	case noEvents
}

protocol BirthdayManagerProtocol {

	func fetchAllBirthdays(completion: @escaping (Result<[Birthday], Error>) -> Void)

}

class BirthdayManager: BirthdayManagerProtocol {

	private var events: [Birthday]?

	func fetchAllBirthdays(completion: @escaping (Result<[Birthday], Error>) -> Void) {
		loadIfNeeded()
		if let events = events {
			completion(.success(events))
		} else {
			let error = BirthdayError.noEvents
			completion(.failure(error))
		}
	}

	private func loadIfNeeded() {
		if events == nil {
			events = [
				Birthday(id: 1, firstName: "Michael", lastName: "Scott", date: Date(), notes: "Ignore him on his birthday"),
				Birthday(id: 2, firstName: "Angella", lastName: nil, date: Date().addingTimeInterval(-10000000), notes: "New cat would be a great present")
			]
		}
	}

}
