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
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "getOption")
        let vc4 = storyBoard.instantiateViewController(withIdentifier: "getJob")
        let vc5 = storyBoard.instantiateViewController(withIdentifier: "getWorry")
        return [vc1, vc2, vc3, vc4, vc5]
    }()
    let pagesCount = 5
    var currentIndex = 0
}

class GetNameViewModel {
    var badwords: [String] = []

    init() {
        madeBadWordsArray()
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

class GetJobViewModel {
    struct Job {
        let title: String
        let imgName: String
    }

    let jobs: [Job] = [Job(title: "중·고등학생", imgName: "HighSchool"), Job(title: "대학(원)생", imgName: "University"), Job(title: "취업준비생", imgName: "Jobseeker"), Job(title: "직장인", imgName: "Worker"), Job(title: "주부", imgName: "Housewife"), Job(title: "기타", imgName: "Etc")]
    var selecteItem: Int? = nil
    let jobsCount: Int?
    let input: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        textField.textColor = UIColor(named: "Gray5")
        textField.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        textField.placeholder = "직접 입력"
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    var keyboardSize: CGSize? = nil

    init() {
        jobsCount = jobs.count
    }
}

class GetOptionViewModel {
    let genderList: [TeritaryBothData] = [TeritaryBothData(imgName: "Male", title: "남성"), TeritaryBothData(imgName: "Female", title: "여성")]
    var gender: String? = nil
    
    var year: String? = nil
    let todayYear = Int(Date().yearFormat())!
}