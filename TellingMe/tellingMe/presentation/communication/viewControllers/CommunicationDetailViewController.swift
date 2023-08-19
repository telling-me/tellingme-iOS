//
//  CommunicationDetailViewController.swift
//  tellingMe
//
//  Created by 마경미 on 28.07.23.
//

import UIKit
import RxSwift
import RxCocoa

class CommunicationDetailViewController: UIViewController {
    //    let viewModel = CommunicationDetailViewModel()
    var pageViewController: CommunicationPageViewController?
    @IBOutlet weak var prevButton: UIView!
    @IBOutlet weak var nextButton: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backHeaderview: BackHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        backHeaderview.delegate = self
        let prevTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickPageControlButton))
        let nextTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickPageControlButton))

        prevButton.tag = 0
        nextButton.tag = 1

        prevButton.addGestureRecognizer(prevTapGestureRecognizer)
        nextButton.addGestureRecognizer(nextTapGestureRecognizer)

        for childViewController in children {
            if let childPageViewController = childViewController as? CommunicationPageViewController {
                pageViewController = childPageViewController
                break
            }
        }
    }

//    func pushCommunicationAnswer(_ indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Communication", bundle: nil)
//        guard let viewController = storyboard.instantiateViewController(identifier: "communicationAnswerViewController") as? CommunicationAnswerViewController else {
//            return
//        }
//        viewController.viewModel.index = viewModel.index
//        let data = CommunicationData.shared.communicationList[viewModel.index][indexPath.row]
//        viewController.viewModel.dataSubject.onNext(CommunicationAnswerViewModel.ReceiveData(indexPath: indexPath, question: QuestionResponse(date: viewModel.question.date, title: viewModel.question.title, phrase: viewModel.question.phrase), answer: data))
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }

    @objc func clickPageControlButton(_ sender: UITapGestureRecognizer) {
        // prev
        if sender.view?.tag == 0 {
            pageViewController?.prevPage()
        } else {
            // next
            pageViewController?.nextPage()
        }
    }
}
