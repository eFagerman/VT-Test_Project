//
//  CustomStepper.swift
//  TicketTest
//
//  Created by Johan Thureson on 2022-03-10.
//

import SwiftUI

struct CustomStepper : View {
    @Binding var value: Int
    var textColor = Color.black
    var accentColor = Color.green
    var dividerColor = Color.gray
    var inactiveColor = Color.gray
    var range = 0...100
    var isAboveLowerBound: Bool {
        value > range.lowerBound
    }
    var isBelowUpperBound: Bool {
        value < range.upperBound
    }
    
    var body: some View {
        HStack {
            
            Text("\(value)")
                .font(.applicationFont(withWeight: .regular, andSize: 17))
                .foregroundColor(textColor)
                .padding()
            
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    if isAboveLowerBound {
                        value -= 1
                        feedback()
                    }
                }, label: {
                    Image(systemName: "minus")
                        .foregroundColor(isAboveLowerBound ? accentColor : inactiveColor)
                })
                
                Spacer()

                Divider()
                    .background(dividerColor)
                    .frame(height: 21)
                
                Spacer()

                Button(action: {
                    if isBelowUpperBound {
                        value += 1
                        feedback()
                    }
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(isBelowUpperBound ? accentColor : inactiveColor)
                })
                
                Spacer()

            }
            .frame(width: 85, height: 32)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(accentColor, lineWidth: 1)
            )

            Spacer().frame(width: 16)
        }
    }
    
    func feedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
}

struct CustomStepper_Previews: PreviewProvider {
    static var previews: some View {
        CustomStepper(value: .constant(2), textColor: .black)
    }
}
