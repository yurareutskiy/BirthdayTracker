//
//  EditFormView.swift
//  BirthdayTracker
//
//  Created by Reutskiy Yura on 26.05.2021.
//  Copyright © 2021 REUTSKIY YURIY. All rights reserved.
//

import SwiftUI

struct RoundButton: ButtonStyle {
    
    var enabled: Bool
    
    init(enabled: Bool = true) {
        self.enabled = enabled
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing))
            .font(.system(size: 20.0, weight: .semibold))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .opacity(enabled ? 1.0 : 0.6)
            .padding()
    }
}

struct EditFormView: View {
    
    @ObservedObject var model: EditFormViewModel
    
    var closeAction: (() -> Void) = {}
    
    var body: some View {
        VStack {
            Form {
                TextField("Name:", text: $model.name)
                DatePicker("Date:", selection: $model.date, displayedComponents: [.date])
                Toggle("Repeat every year:", isOn: $model.isRepeatable)
            }
            
            Button("Save", action: closeAction)
                .disabled(!model.isValid)
                .buttonStyle(RoundButton(enabled: model.isValid))
            
        }
    }
}

struct EditFormView_Previews: PreviewProvider {
    
    static var previews: some View {
        EditFormView(model: EditFormViewModel(editType: .addNew))
    }
}
