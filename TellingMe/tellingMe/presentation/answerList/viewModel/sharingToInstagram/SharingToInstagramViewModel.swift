//
//  SharingToInstagramViewModel.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/12.
//

import UIKit

import RxCocoa
import RxSwift

protocol SharingToInstagramInputs {
    func saveImageTapped()
    func shareImageToInstagramTapped()
    func openSharingControllerTapped(completion: @escaping (UIImage) -> Void)
}

protocol SharingToInstagramOutputs {
    var sharingTableElements: Observable<[String]> { get }
    var imageSavedSuccess: PublishSubject<(Bool, Error?)> { get }
}

protocol SharingToInstagramType {
    var inputs: SharingToInstagramInputs { get }
    var outputs: SharingToInstagramOutputs { get }
}

final class SharingToInstagramViewModel: NSObject, SharingToInstagramInputs, SharingToInstagramOutputs, SharingToInstagramType {
    
    enum SharingType {
        case myAnswers
        case myLibrary
    }
    
    enum SharingPlatform {
        case kakao
        case instagram
        case toAlbum
        
        var platform: String {
            switch self {
            case .kakao:
                return "Kakao"
            case .instagram:
                return "Instagram"
            case .toAlbum:
                return "Saved to album"
            }
        }
    }
    
    private let metaManager = MetaManager()
    private var sharingView: UIView = UIView()
    private let sharingTableElementsArray: [String] = ["이미지로 저장하기", "인스타 스토리로 공유하기", "다른 방법으로 공유하기"]
    private var sharingType: SharingType = .myAnswers
    private var disposeBag = DisposeBag()
    
    var sharingTableElements: Observable<[String]>
    var imageSavedSuccess: PublishSubject<(Bool, Error?)> = PublishSubject<(Bool, Error?)>()
    
    var inputs: SharingToInstagramInputs { return self }
    var outputs: SharingToInstagramOutputs { return self }
    
    override init() {
        self.sharingTableElements = Observable.just(sharingTableElementsArray)
    }
    
    func saveImageTapped() {
        let renderedImage = setSharingImageWithBackground()
        UIImageWriteToSavedPhotosAlbum(renderedImage, self, #selector(imageError), nil)
    }
    
    func shareImageToInstagramTapped() {
        setSharingImage()
        postSharingAction(type: .instagram)
    }
    
    func openSharingControllerTapped(completion: @escaping (UIImage) -> Void) {
        let renderedImage = setSharingImageWithBackground()
        completion(renderedImage)
    }
}

extension SharingToInstagramViewModel {
    @objc
    private func imageError(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            imageSavedSuccess.onNext((false,error))
        } else {
            imageSavedSuccess.onNext((true, nil))
            postSharingAction(type: .toAlbum)
        }
    }
    
    private func setSharingImage() {
        let currentDevice = UIDevice.current.name
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let height = appDelegate.deviceHeight
        let width = appDelegate.deviceWidth
        let addedViewHeight = height/1.68
        let addedViewWidth = width/1.24
        var stickerYPointCalculated = addedViewHeight/1.42
        
        let isDeviceAbnormal = UserDefaults.standard.bool(forKey: StringLiterals.isDeviceAbnormal)
        
        if isDeviceAbnormal != false {
            stickerYPointCalculated = addedViewHeight/1.48
        }
        
        if currentDevice == "iPhone 12 mini" || currentDevice == "iPhone 13 mini" {
            stickerYPointCalculated = addedViewHeight/1.46
        }

        DeviceSecondaryAbnormal.allCases.forEach { device in
            if device.deviceName == currentDevice {
                stickerYPointCalculated = addedViewHeight/1.46
                return
            }
        }
        
        let stickerXPoint: CGFloat = addedViewWidth/3
        let stickerYPoint: CGFloat = stickerYPointCalculated
        let stickerWidth = width/1.25
        let stickerheight = height/4.06

        let cardImage = metaManager.saveImage(from: self.sharingView)
        let signatureImage = UIImage(named: "SignatureSticker")

        let backgroundView = SharingBackgroundView(frame: .zero, sharingImage: cardImage, signatureImage: signatureImage)
        backgroundView.frame = CGRect(x: 0, y: 0, width: addedViewWidth, height: addedViewHeight)
        let shadowView = backgroundView.subviews[0]
        let addedView = backgroundView.subviews[1]
        let stickerView = backgroundView.subviews[2]
        shadowView.frame = CGRect(x: 0, y: 0, width: addedViewWidth-24, height: addedViewHeight-24)
        addedView.frame = CGRect(x: 0, y: 0, width: addedViewWidth-20, height: addedViewHeight-20)
        
        if sharingType == .myLibrary {
            backgroundView.setInsetForImage()
        } else {
            stickerView.frame = CGRect(x: -stickerXPoint, y: stickerYPoint, width: stickerWidth, height: stickerheight)
        }
        addedView.center = backgroundView.center
        shadowView.center = backgroundView.center
        
        backgroundView.backgroundColor = .clear
        shadowView.backgroundColor = .Black
        shadowView.layer.cornerRadius = 28
        shadowView.layer.masksToBounds = true
        shadowView.layer.shadowRadius = 6
        shadowView.layer.shadowOpacity = 0.25
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = UIColor.Gray5.cgColor
        shadowView.layer.masksToBounds = false
        addedView.backgroundColor = .Side100
        addedView.cornerRadius = 28
        addedView.layer.masksToBounds = true
        backgroundView.cornerRadius = 28
        
        metaManager.shareInstagram(sharingView: backgroundView)
    }

    private func setSharingImageWithBackground() -> UIImage {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return UIImage() }
        let height = appDelegate.deviceHeight
        let width = appDelegate.deviceWidth
        let addedViewHeight = height/1.68
        let addedViewWidth = width/1.24
        var heightMinus = height/9.2

        let isDeviceAbnormal = UserDefaults.standard.bool(forKey: StringLiterals.isDeviceAbnormal)

        if isDeviceAbnormal != false {
            heightMinus = height/8.2
        }

        let stickerXPoint = addedViewWidth/2 - width/4.3
        let stickerYPoint = height/2 + addedViewHeight/2.5 - heightMinus
        let stickerWidth = width/1.25
        let stickerheight = height/4.06

        let cardImage = metaManager.saveImage(from: self.sharingView)
        let signatureImage = UIImage(named: "SignatureSticker")

        let backgroundView = SharingBackgroundView(frame: .zero, sharingImage: cardImage, signatureImage: signatureImage)
        backgroundView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let shadowView = backgroundView.subviews[0]
        let addedView = backgroundView.subviews[1]
        let stickerView = backgroundView.subviews[2]
        shadowView.frame = CGRect(x: 0, y: 0, width: addedViewWidth-4, height: addedViewHeight-4)
        addedView.frame = CGRect(x: 0, y: 0, width: addedViewWidth, height: addedViewHeight)

        if sharingType == .myLibrary {
            backgroundView.setInsetForImage()
            backgroundView.moveSignatureViewToCenter(image: UIImage(named: "SignatureSticker2"))
            stickerView.frame = CGRect(x: backgroundView.center.x/2 - (backgroundView.frame.width-addedViewWidth)/2 - 20, y: backgroundView.center.y + addedViewHeight/4 , width: stickerWidth, height: stickerheight*2)
        } else {
            stickerView.frame = CGRect(x: -stickerXPoint, y: stickerYPoint, width: stickerWidth, height: stickerheight)
        }
        addedView.center = backgroundView.center
        shadowView.center = backgroundView.center

        backgroundView.backgroundColor = .Side100
        shadowView.backgroundColor = .Black
        shadowView.layer.cornerRadius = 28
        shadowView.layer.masksToBounds = true
        shadowView.layer.shadowRadius = 12
        shadowView.layer.shadowOpacity = 0.25
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        shadowView.layer.shadowColor = UIColor.Gray5.cgColor
        shadowView.layer.masksToBounds = false
        addedView.backgroundColor = .Side100
        addedView.cornerRadius = 28
        addedView.layer.masksToBounds = true
        
        let savedImage = metaManager.saveImage(from: backgroundView)
        
        return savedImage
    }
    
    private func postSharingAction(type: SharingPlatform) {
        ShareAPI.postShareType(request: .init(type: type.platform))
            .subscribe(onNext: { _ in })
            .disposed(by: disposeBag)
    }
}

extension SharingToInstagramViewModel {
    func passUIViewData(_ view: UIView) {
        self.sharingView = view
    }
    
    func changeSharingViewType() {
        self.sharingType = .myLibrary
    }
}
