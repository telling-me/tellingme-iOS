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
    @IBOutlet var animationViews: [UIImageView]!
    @IBOutlet var shadowViews: [UIImageView]!
    @IBOutlet weak var rotateAnimationView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    override func viewDidAppear(_ animated: Bool) {
        animation()
    }

    func setView() {
        questionView.setShadow(shadowRadius: 20)
        dayStackView.setShadow(shadowRadius: 20)
        writeButton.setShadow(shadowRadius: 16)

        questionLabel.textColor = UIColor(named: "Logo")
        subQuestionLabel.textColor = UIColor(named: "Gray5")
        dayLabel.textColor = UIColor(named: "Side500")
        dayStackLabel.textColor = UIColor(named: "Logo")

        for view in shadowViews {
            view.setShadow2()
        }

        getQuestion()
    }

    func animation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            let scale = CGAffineTransform(translationX: 0, y: 10)
            self.animationViews[0].transform = scale
            self.animationViews[1].transform = scale
            self.animationViews[2].transform = scale
            self.animationViews[3].transform = scale
        }

        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear]) {
            let scale = CGAffineTransform(rotationAngle: .pi / 2)
            self.rotateAnimationView.transform = scale
        }
    }

    @IBAction func presentEmotion(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "emotion") as? EmotionViewController else { return }

        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .coverVertical

        self.present(vc, animated: false)
    }
}
