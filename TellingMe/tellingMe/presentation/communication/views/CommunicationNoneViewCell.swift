////
////  CommunicationNoneViewCell.swift
////  tellingMe
////
////  Created by 마경미 on 14.08.23.
////
//
//import UIKit
//
//class CommunicationNoneViewCell: UICollectionViewCell {
//    static let id = "communicationNoneViewCell"
//    let noneView: NoneAnswerListView = {
//        let view = NoneAnswerListView()
//        view.label.text = "아직 올라온 글이 없어요!"
//        view.smallImage()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//            setView()
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            super.init(coder: aDecoder)
//            setView()
//        }
//
//        func setView() {
//            contentView.addSubview(noneView)
//            noneView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
//            noneView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
//            noneView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//            noneView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        }
//}
