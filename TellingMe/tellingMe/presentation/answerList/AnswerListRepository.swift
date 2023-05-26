//
//  AnswerListRepository.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation

extension AnswerListViewController {
    func getAnswerList() {
        let month = viewModel.month
        let year = viewModel.year
        AnswerAPI.getAnswerList(month: month, year: year) { result in
            switch result {
            case .success(let response):
                self.viewModel.answerList = response
                self.viewModel.answerCount = response?.count ?? 0
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
