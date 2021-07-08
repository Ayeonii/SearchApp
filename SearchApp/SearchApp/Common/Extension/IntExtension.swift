//
//  IntExtension.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/22.
//

import Foundation

extension Int {
    func Decimal() -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value : self))!
        
        return result
    }
    
    func countNum() -> String {
        if self < 1000 {
            return self.Decimal()
        }
        if self >= 1000, self < 10000 {
            let str = self.makeNumberToShortString(100)
            
            return "\(str)천"
        } else if self >= 10000 , self < 100000000 {
            let str = self.makeNumberToShortString(1000)

            return "\(str)만"
        } else if self >= 100000000{
            let str = self.makeNumberToShortString(1000000)
            return "\(str)억"
        }
        return ""
    }
    
    func makeNumberToShortString(_ unit : Double) -> String {
        let roundedNumDouble = ceil((Double(self) / unit)) / 10
        
        let roundedNumStr = roundedNumDouble.truncatingRemainder(dividingBy: 1) < 0.1 ? String(format: "%.0f", roundedNumDouble) : String(format: "%.1f", roundedNumDouble)
        return roundedNumStr
    }
}
