//
//  CommunicationDetailCell.swift
//  tellingMe
//
//  Created by 마경미 on 28.07.23.
//

import UIKit
//import RxSwift

protocol SendLikeDelegate: AnyObject {
    func likeButtonClicked(answerId: Int)
}

class CommunicationDetailCollectionViewCell: UICollectionViewCell {
    static let id = "communicationDetailCollectionViewCell"
    weak var delegate: SendLikeDelegate?
//    let disposeBag = DisposeBag()

    var index = 0
    var answerId: Int = 0
    var indexPath: IndexPath = IndexPath()
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let emotionView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let emotionLabel: Body2Bold = {
        let label = Body2Bold()
        label.textColor = UIColor(named: "Gray7")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let emotionBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Side100")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let answerLabel: Body2Regular = {
        let label = Body2Regular()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(named: "Heart.fill"), for: .selected)
        button.setTitleColor(UIColor(named: "Gray7"), for: .normal)
        button.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFB", size: 12)
        button.tintColor = UIColor(named: "Gray6")
        let spacing: CGFloat = 4
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
//
//    var buttonTapped: Observable<Void> {
//        return likeButton.rx.tap.asObservable()
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }

    func setView() {
        self.layer.cornerRadius = 12

        contentView.backgroundColor = UIColor(named: "Side200")
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true

        containerView.addSubview(emotionView)
        emotionView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        emotionView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        emotionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        emotionView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true

        containerView.addSubview(emotionBackgroundView)
        emotionBackgroundView.leadingAnchor.constraint(equalTo: emotionView.trailingAnchor, constant: 8).isActive = true
        emotionBackgroundView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        emotionBackgroundView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        emotionBackgroundView.addSubview(emotionLabel)
        emotionLabel.leadingAnchor.constraint(equalTo: emotionBackgroundView.leadingAnchor, constant: 4).isActive = true
        emotionLabel.trailingAnchor.constraint(equalTo: emotionBackgroundView.trailingAnchor, constant: -4).isActive = true
        emotionLabel.centerYAnchor.constraint(equalTo: emotionBackgroundView.centerYAnchor).isActive = true

        emotionBackgroundView.layer.cornerRadius = 4

        containerView.addSubview(answerLabel)
        answerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        answerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        answerLabel.topAnchor.constraint(equalTo: emotionView.bottomAnchor, constant: 8).isActive = true

        containerView.addSubview(likeButton)
//        likeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        likeButton.topAnchor.constraint(equalTo: answerLabel.bottomAnchor).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true

        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        contentView.layer.cornerRadius = 12
    }
    
    @objc func likeButtonTapped() {
        delegate?.likeButtonClicked(answerId: answerId)
        let (isLike, likeCount) = CommunicationData.shared.toggleLike(index: index, indexPath: indexPath)
        likeButton.isSelected = isLike
        if likeCount == 0 {
            likeButton.setTitle("", for: .normal)
        } else {
            likeButton.setTitle("\(likeCount)", for: .normal)
        }
    }

    func setData(index: Int, indexPath: IndexPath, data: Content) {
        self.index = index
        self.answerId = data.answerId
        self.indexPath = indexPath
        answerLabel.text = data.content
        emotionView.image = UIImage(named: emotions[data.emotion-1].image)
        emotionLabel.text = emotions[data.emotion-1].text

        likeButton.isSelected = data.isLiked
        if data.likeCount != 0 {
            likeButton.setTitle("\(data.likeCount)", for: .normal)
        } else {
            likeButton.setTitle("", for: .normal)
        }
        emotionLabel.sizeToFit()
    }
}
