//
//  HomeViewController.swift
//  tellingMe
//
//  Created by 마경미 on 22.03.23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var dayStackView: UIView!
    @IBOutlet weak var dayStackLabel: CaptionLabelBold!
    @IBOutlet weak var dayLabel: CaptionLabelRegular!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var subQuestionLabel: Body2Regular!
    @IBOutlet weak var questionLabel: Body1Regular!

    @IBOutlet var shadowViews: [UIImageView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    func setView() {
        questionView.setShadow(shadowRadius: 20, cornerRadius: 28)
        dayStackView.setShadow(shadowRadius: 20, cornerRadius: 8)
        writeButton.setShadow(shadowRadius: 16, cornerRadius: 20)

        questionLabel.textColor = UIColor(named: "Logo")
        subQuestionLabel.textColor = UIColor(named: "Gray5")
        dayLabel.textColor = UIColor(named: "Side500")
        dayStackLabel.textColor = UIColor(named: "Logo")

        for view in shadowViews {
            view.setShadow2()
        }
    }

    @IBAction func presentEmotion(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "emotion") as? EmotionViewController else { return }

        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical

        self.present(vc, animated: false)
    }
}
