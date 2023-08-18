//
//  CommunityViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.07.23.
//

import UIKit

class CommunityViewController: UIViewController {
    let viewModel = CommunicationViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    @IBOutlet weak var cardStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.color = .gray // 인디케이터 색상 설정
        activityIndicator.center = view.center // 화면 중앙에 위치
        activityIndicator.hidesWhenStopped = true // 정지 상태일 때 숨김
        view.addSubview(activityIndicator)
        view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        getQuestionList() {
            self.setCardView()
            self.cardStackView.isHidden = false
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
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
        CommunicationData.shared.currentIndex = view.tag
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
