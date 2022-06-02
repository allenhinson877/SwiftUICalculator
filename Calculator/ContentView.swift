//
//  ContentView.swift
//  Calculator
//
//  Created by William Hinson on 3/14/22.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "±"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .divide, .multiply, .clear, .percent, .negative:
                return Color("Cream")
        case .equal:
                return Color.orange
        default: return Color.white
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
         [.seven, .eight, .nine, .multiply],
         [.four, .five, .six, .subtract],
         [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
        
    ]
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if value.count > 6 {
                        Text(value)
                            .font(.system(size: 55))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    } else {
                        Text(value)
                        .font(.system(size: 90))

                        .foregroundColor(.white)
                    }
                  
                }
                .padding()
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button {
                                self.didTapButton(button: item)
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: 40, weight: .semibold, design: .default))
                                    .foregroundColor(.black)
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            }

                        }
                    }
                    .padding(5)
                }
            }.padding(24)
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .equal {
            return (UIScreen.main.bounds.width - (5*12)) / 4 * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4.25
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4.25
    }
    
    func didTapButton(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0
            } else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0
            } else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0
            } else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0
            } else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                    if (Double(self.value)!.truncatingRemainder(dividingBy: 1) == 0) {
                        self.value = "\(Int(Double(self.value)!))"
                    }
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                    if (Double(self.value)!.truncatingRemainder(dividingBy: 1) == 0) {
                        self.value = "\(Int(Double(self.value)!))"
                    }
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                    if (Double(self.value)!.truncatingRemainder(dividingBy: 1) == 0) {
                        self.value = "\(Int(Double(self.value)!))"
                    }
                case .divide:
                    self.value = "\(runningValue / currentValue)"
                    if (Double(self.value)!.truncatingRemainder(dividingBy: 1) == 0) {
                        self.value = "\(Int(Double(self.value)!))"
                    }
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal:
            self.value = "\(self.value)" + "."
        case .percent:
            let newNumber = Double(self.value) ?? 0
            let percentage = newNumber / 100
            self.value = "\(percentage)"
        case .negative:
            if self.value != "" {
                self.value = "\(-Double(self.value)!)"
                
                if (Double(self.value)!.truncatingRemainder(dividingBy: 1) == 0) {
                    self.value = "\(Int(Double(self.value)!))"
                }
            }
            
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
