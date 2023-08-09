//
//  CommunityViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.07.23.
//

import UIKit

class CommunityViewController: UIViewController {
    let viewModel = CommunicationViewModel()
    @IBOutlet weak var cardStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getQuestionList() {
            self.setCardView()
            CommunicationData.shared?.threeDays = self.viewModel.data
        }
    }

    func setCardView() {
        var index = 0
        for cardView in cardStackView.arrangedSubviews {
            guard let communityCardView = cardView as? CommunityCardView else {
                return
            }
            communityCardView.tag = index
            communityCardView.delegate = self
            communityCardView.setData(data: viewModel.data[index])
            index += 1
        }
    }
}

extension CommunityViewController: CommunityDelegate {
    func communicationButtonClicked(_ view: CommunityCardView) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "communicationDetailViewController") as? CommunicationDetailViewController else {
            return
        }
        CommunicationData.shared?.currentIndex = view.tag
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
