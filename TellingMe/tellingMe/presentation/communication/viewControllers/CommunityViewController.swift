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
            self.setStackView()
            self.cardStackView.isHidden = false
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func setStackView() {
        var index = 0
        // 이것도 시간체크해서 매번 api 호출말고 오전 6시에 바뀌도록 해야할듯
        for subview in cardStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        
        for data in viewModel.data {
            let communityCardView = CommunityCardView()
            cardStackView.frame.size.height = 142
            communityCardView.tag = index
            communityCardView.delegate = self
            communityCardView.setData(data: data)
            cardStackView.addArrangedSubview(communityCardView)
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
