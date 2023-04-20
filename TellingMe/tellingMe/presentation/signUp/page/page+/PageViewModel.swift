//
//  PageViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 13.04.23.
//

import Foundation
import UIKit

class SignUpPaveViewModel {
    let pages: [UIViewController] = {
        let storyBoard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "agreement")
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "getName")
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "getWorry")
        let vc4 = storyBoard.instantiateViewController(withIdentifier: "getJob")
        let vc5 = storyBoard.instantiateViewController(withIdentifier: "getGender")
        let vc6 = storyBoard.instantiateViewController(withIdentifier: "getBirthday")
        let vc7 = storyBoard.instantiateViewController(withIdentifier: "getMBTI")
        return [vc1, vc2, vc3, vc4, vc5, vc6, vc7]
    }()
    let pagesCount = 7
    var currentIndex = 0
}

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
