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
        getQuestionList()
    }
    
    func setCardView() {
        var index = 0
        for cardView in cardStackView.arrangedSubviews {
            guard let communityCardView = cardView as? CommunityCardView else {
                return
            }
            
            communityCardView.setData(data: viewModel.data[index])
            index += 1
        }
    }
}
