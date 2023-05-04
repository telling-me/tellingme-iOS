//
//  AnswerListRepository.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation

extension AnswerListViewController {
    func getAnswerList() {
        AnswerAPI.getAnswerList(query: "2023/04/01") { result in
            switch result {
            case .success(let response):
                self.viewModel.answerList = response
                self.viewModel.answerCount = response!.count
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
