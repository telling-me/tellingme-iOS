//
//  AnswerListRepository.swift
//  tellingMe
//
//  Created by 마경미 on 04.05.23.
//

import Foundation

extension AnswerListViewController {
    func getAnswerList() {
        let query = viewModel.getQueryDate()
        AnswerAPI.getAnswerList(query: query) { result in
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
