//
//  Array+.swift
//  tellingMe
//
//  Created by 마경미 on 07.04.23.
//

import Foundation

extension Array {
    func intArraytoString() -> String {
        var string = "["
        for i in 0..<self.count {
            string += "\(self[i])"
            if i != self.count - 1 {
                string += ", "
            }
        }
        string += "]"
        return string
    }
}
