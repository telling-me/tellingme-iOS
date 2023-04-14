//
//  PageViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 13.04.23.
//

import Foundation

class GetNameViewModel {
    var badwords: [String] = []

    init() {
    }

    func madeBadWordsArray() {
        if let filepath = Bundle.main.path(forResource: "badWords", ofType: "txt" ) {
            do {
                let contents = try String(contentsOfFile: filepath)
                let lines = contents.components(separatedBy: ",")
                badwords = lines
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
