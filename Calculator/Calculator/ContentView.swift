//
//  ContentView.swift
//  Calculator
//
//  Created by Abdulsamet Göçmen on 14.09.2021.
//

import SwiftUI

enum CalculatorButtons:String{
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
    case substract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .substract, .multiply, .divide, .equal:
            return.orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
    
}

enum Operation {
    case add, subtract, multiply, divide, none
    
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runingNumber = 0
    @State var currentOperations: Operation = .none
    
    let buttons:[[CalculatorButtons]] = [
        [ .clear, .negative, .percent, .divide],
        [ .seven, .eight, .nine, .multiply],
        [ .four, .five, .six, .substract],
        [ .one, .two, .three,.add],
        [ .zero, .decimal, .equal]
    ]
    
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Spacer()
                
                //Text display
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                 // Our buttons
                ForEach(buttons, id: \.self){row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self){item in
                            Button(action:{
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size:32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom,3)
                }
            }
        }
    }
    
    func didTap(button: CalculatorButtons){
        switch button {
        case .add, .substract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperations = .add
                self.runingNumber += Int(self.value) ?? 0
            } else if button == .substract {
                self.currentOperations = .subtract
                self.runingNumber += Int(self.value) ?? 0
            }else if button == .multiply {
                self.currentOperations = .multiply
                self.runingNumber += Int(self.value) ?? 0
            }else if button == .divide {
                self.currentOperations = .divide
                self.runingNumber += Int(self.value) ?? 0
            }else if button == .equal {
                let runingValue = self.runingNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperations {
                case .add: self.value="\(runingValue + currentValue)"
                case .subtract: self.value="\(runingValue - currentValue)"
                case .multiply: self.value="\(runingValue * currentValue)"
                case .divide: self.value="\(runingValue / currentValue)"
                case .none: break
                default:
                    break
                }
            }
            if button != .equal{
                self.value = "0"
            }
        case .clear:
            self.value="0"
            break
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalculatorButtons) -> CGFloat{
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4)*2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
    
}
