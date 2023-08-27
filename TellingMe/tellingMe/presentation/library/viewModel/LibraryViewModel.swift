//
//  LibraryViewModel.swift
//  tellingMe
//
//  Created by 마경미 on 26.08.23.
//

import Foundation
import RxSwift
import RxCocoa

protocol LibraryViewModelInputs {
    var selectedYear: Int { get set }
    var selectedMonth: Int { get set }
    func refresh()
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
}

protocol LibraryViewModelOutputs {
    var answerLists: BehaviorSubject<[AnswerListResponse]> { get }
}

protocol LibraryViewModelType {
    var inputs: LibraryViewModelInputs { get }
    var outputs: LibraryViewModelOutputs { get }
}

public final class LibraryViewModel: LibraryViewModelType, LibraryViewModelInputs, LibraryViewModelOutputs {

    public let dates: [[Int: [Int]]] = [
        [1: Array(1...31)], [2: Array(1...28)],
        [3: Array(1...31)], [4: Array(1...30)],
        [5: Array(1...31)], [6: Array(1...30)],
        [7: Array(1...31)], [8: Array(1...30)],
        [9: Array(1...31)], [10: Array(1...30)],
        [11: Array(1...31)], [12: Array(1...30)]
    ]
    public let years: [Int] = Array(2023...(Int(Date().yearFormat()) ?? 2023))
    public let months: [Int] = Array(1...12)
    public var answerListCount: Int {
        guard let answerListCount = try? answerLists.value().count else {
            return 0
        }
        return answerListCount
    }
    
    // input
    public var selectedYear: Int = Int(Date().yearFormat()) ?? 2023
    public var selectedMonth: Int = Int(Date().monthFormat()) ?? 1

    // output
    var answerLists: BehaviorSubject<[AnswerListResponse]> = BehaviorSubject(value: [])

    private var disposeBag = DisposeBag()
    var inputs: LibraryViewModelInputs { return self }
    var outputs: LibraryViewModelOutputs { return self }
    
    public func refresh() {}
    
    public func viewDidLoad() {}
    
    public func viewWillAppear(animated: Bool) {}
    
}
