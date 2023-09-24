//
//  NSObject+.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/24.
//

import Foundation

extension NSObject {
    var className: String {
       NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
   }
}
