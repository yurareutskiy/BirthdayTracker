//
//  EditFormViewModel.swift
//  BirthdayTracker
//
//  Created by Reutskiy Yura on 26.05.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import Foundation
import Combine

enum EditType {
    case addNew
    case editExisting
}

class EditFormViewModel: ObservableObject {
    
    let editType: EditType
    let completion: BirthdayCallback?
    
    @Published var name: String = ""
    @Published var date: Date = Date()
    @Published var isRepeatable: Bool = false
    @Published var isValid: Bool = false
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(editType: EditType, completion: BirthdayCallback? = nil) {
        self.editType = editType
        self.completion = completion
        setupSubscriptions()
    }
    
    var title: String {
        switch editType {
        case .addNew:
            return "Add new"
        case .editExisting:
            return "Edit"
        }
    }
    
    private func setupSubscriptions() {
        Publishers.CombineLatest($name, $date)
        .map { (name, date) in
            name.count > 0 && date.compare(Date()) == .orderedDescending
        }
        .assign(to: \.isValid, on: self)
        .store(in: &subscriptions)
    }
    
    func close() {
        completion?(.failure(BirthdayError.common))
    }
    
}
