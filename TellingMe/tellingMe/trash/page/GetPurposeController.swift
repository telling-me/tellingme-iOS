////
////  GetWorryViewController.swift
////  tellingMe
////
////  Created by 마경미 on 27.03.23.
////
//
//import UIKit
//
//class GetPurposeViewController: UIViewController {
//    let purposeList: [TeritaryBothData] = [TeritaryBothData(imgName: "Pen", title: "학업/진로"), TeritaryBothData(imgName: "Handshake", title: "대인 관계"), TeritaryBothData(imgName: "Values", title: "성격/가치관"), TeritaryBothData(imgName: "Magnet", title: "행동/습관"), TeritaryBothData(imgName: "Health", title: "건강"), TeritaryBothData(imgName: "Etc", title: "기타")]
//    var selectedItems: [Int] = []
//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var nextButton: SecondaryIconButton!
//    @IBOutlet weak var prevButton: SecondaryIconButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView.allowsMultipleSelection = true
//        prevButton.setImage(image: "ArrowLeft")
//        nextButton.isEnabled = false
//        nextButton.setImage(image: "ArrowRight")
//    }
//    
//    func pushHome() {
//        // 로그인 화면의 뷰 컨트롤러를 생성합니다.
//        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
//        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? MainTabBarController else { return }
//        // MainTabBar의 두 번째 탭으로 이동합니다.
//        tabBarController.selectedIndex = 0
//        
//        // 로그인 화면을 윈도우의 rootViewController로 설정합니다.
//        guard let window = UIApplication.shared.windows.first else {
//            return
//        }
//        window.rootViewController = tabBarController
//        window.makeKeyAndVisible()
//        
//        tabBarController.showPushNotification()
//    }
//    
//    @IBAction func nextAction(_ sender: UIButton) {
//        sender.isEnabled = false
//        SignUpData.shared.purpose = selectedItems.sorted().intArraytoString()
//        sendSignUpData()
//    }
//    
//    @IBAction func prevAction(_ sender: UIButton) {
//        let pageViewController = self.parent as? SignUpPageViewController
//        pageViewController?.prevPage()
//    }
//}
//
//extension GetPurposeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return purposeList.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeritaryVerticalBothButtonCell.id, for: indexPath) as? TeritaryVerticalBothButtonCell else { return UICollectionViewCell() }
//        cell.setData(with: purposeList[indexPath.row])
//        cell.contentView.addSubview(UILabel())
//        cell.layer.cornerRadius = 20
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 103, height: 114)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return collectionView.indexPathsForSelectedItems!.count <  2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 24
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView.indexPathsForSelectedItems!.count > 0 {
//            nextButton.isEnabled = true
//            selectedItems.append(indexPath.row)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if collectionView.indexPathsForSelectedItems!.count == 0 {
//            nextButton.isEnabled = false
//        }
//        if let index = selectedItems.firstIndex(of: indexPath.row) {
//            selectedItems.remove(at: index)
//        }
//    }
//}
