//
//  SharingBottomViewController.swift
//  tellingMe
//
//  Created by KYUBO A. SHIM on 2023/09/12.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class SharingBottomViewController: UIViewController {
    
    private let viewModel = SharingToInstagramViewModel()
    private var disposeBag = DisposeBag()
    
    private let sharingTableView = UITableView()
    private let loadingView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setStyles()
        setLayout()
    }
    
    deinit {
        print("SharingBottomViewController Out")
    }
}

extension SharingBottomViewController {
    
    private func bindViewModel() {
        viewModel.outputs.sharingTableElements
            .bind(to: sharingTableView.rx.items(cellIdentifier: "sharingTableView", cellType: SharingToInstagramTableViewCell.self)) {
                index, data, cell in
                cell.configure(title: data)
            }
            .disposed(by: disposeBag)
        
        sharingTableView.rx.itemSelected
            .bind(onNext: { [weak self] indexPath in
                guard let self else { return }
                self.sharingTableView.deselectRow(at: indexPath, animated: true)
                let index = indexPath.row
                switch index {
                case 0:
                    self.loadingViewActivate()
                    self.viewModel.inputs.saveImageTapped()
                case 1:
                    self.viewModel.inputs.shareImageToInstagramTapped()
                case 2:
                    self.viewModel.inputs.openSharingControllerTapped(completion: { image in
                        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                        activityViewController.excludedActivityTypes = [.addToReadingList, .saveToCameraRoll, .airDrop, .copyToPasteboard, .mail]
                        self.present(activityViewController, animated: true)
                    })
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.imageSavedSuccess
            .asObserver()
            .subscribe(onNext: { [weak self] success, error in
                guard let self else { return }
                setToastAnimation(type: success)
                self.loadingView.stopAnimating()
                self.loadingView.removeFromSuperview()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setStyles() {
        view.backgroundColor = .Side100
        
        sharingTableView.do {
            $0.rowHeight = 56
            $0.separatorStyle = .none
            $0.register(SharingToInstagramTableViewCell.self, forCellReuseIdentifier: "sharingTableView")
        }
        
        loadingView.do {
            $0.color = .Logo
            $0.style = .medium
            $0.alpha = 0
        }
    }
    
    private func setLayout() {
        view.addSubview(sharingTableView)
        
        sharingTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(36)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setToastAnimation(type: Bool) {
        
        let toastView = ImageSavedToastView(frame: .zero, type: type ? .successed : .failed)
        view.addSubview(toastView)
        
        toastView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(50)
        }
        
        UIView.animate(withDuration: 1.2, delay: 1.0, options: .curveEaseOut) { [weak self] in
            self?.sharingTableView.isUserInteractionEnabled = false
            toastView.alpha = 0
        } completion: { [weak self] _ in
            toastView.removeFromSuperview()
            self?.sharingTableView.isUserInteractionEnabled = true
        }
    }
    
    private func loadingViewActivate() {
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        loadingView.alpha = 1
        loadingView.startAnimating()
    }
}

extension SharingBottomViewController {
    func passUIView(_ view: UIView) {
        viewModel.passUIViewData(view)
    }
    
    func changeSharingViewType() {
        viewModel.changeSharingViewType()
    }
}
