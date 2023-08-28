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
    var answerListCount: BehaviorSubject<Int> { get }
    var answerLists: BehaviorSubject<[LibraryAnswerList]> { get }
    var toastSubject: BehaviorSubject<String> { get }
}

protocol LibraryViewModelType {
    var inputs: LibraryViewModelInputs { get }
    var outputs: LibraryViewModelOutputs { get }
}

public final class LibraryViewModel: LibraryViewModelType, LibraryViewModelInputs, LibraryViewModelOutputs {

    public let dates: [Int: [Int]] = [
        1: Array(1...31), 2: Array(1...28), 3: Array(1...31),
        4: Array(1...30), 5: Array(1...31), 6: Array(1...30),
        7: Array(1...31), 8: Array(1...30), 9: Array(1...31),
        10: Array(1...30), 11: Array(1...31), 12: Array(1...30)
    ]
    public let years: [Int] = Array(2023...(Int(Date().yearFormat()) ?? 2023))
    public let months: [Int] = Array(1...12)
    
    // input
    public var selectedYear: Int = Int(Date().yearFormat()) ?? 2023
    public var selectedMonth: Int = Int(Date().monthFormat()) ?? 1

    // output
    var answerListCount: BehaviorSubject<Int> = BehaviorSubject(value: 0)
    var answerLists: BehaviorSubject<[LibraryAnswerList]> = BehaviorSubject(value: [])
    let toastSubject =  BehaviorSubject<String>(value: "")

    private var disposeBag = DisposeBag()
    var inputs: LibraryViewModelInputs { return self }
    var outputs: LibraryViewModelOutputs { return self }
    
    init() {
        fetchAnswerList()
    }
    
    public func refresh() {}
    
    public func viewDidLoad() {}
    
    public func viewWillAppear(animated: Bool) {}
    
}

extension LibraryViewModel {
    func fetchAnswerList() {
        AnswerAPI.getAnswerList(month: "\(selectedMonth)", year: "\(selectedYear)")
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                self.answerListCount.onNext(response.count)
                self.answerLists.onNext(self.remakeData(list: response))
             }, onError: { error in
                 switch error {
                 case APIError.errorData(let errorData):
                     self.toastSubject.onNext(errorData.message)
                 default:
                     self.toastSubject.onNext("Error occured!")
                 }
             })
             .disposed(by: disposeBag)
    }
    
    func remakeData(list: [AnswerListResponse]) -> [LibraryAnswerList] {
        let existDates = list.map { $0.date[2] }
        var result: [LibraryAnswerList] = []
        for date in dates[selectedMonth]! {
            var temp: LibraryAnswerList = LibraryAnswerList()
            if let index = existDates.firstIndex(of: date) {
                temp.isEmpty = false
                temp.emotion = Emotions(intValue: list[index].emotion - 1) ?? .happy
            }
            if date % 7 == 0 {
                temp.isLast = true
            }
            result.append(temp)
        }
        for i in 0..<4 {
            for j in [6, 5, 4, 3, 2, 1, 0] {
                let index = i * 7 + j
                if result[index].isEmpty {
                    if (index % 7) != 0 {
                        result[index - 1].isLast = true
                    }
                    result[index].isLast = false
                } else {
                    if result[index-1].isEmpty {
                        result[index].isLast = false
                    }
                    break
                }
            }
        }
        return result
    }
}

struct LibraryAnswerList {
    var emotion: Emotions = .happy
    var isEmpty: Bool = true
    var isLast: Bool = false
}
