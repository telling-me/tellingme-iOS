//
//  CommunicationViewController.swift
//  tellingMe
//
//  Created by 마경미 on 29.07.23.
//

import UIKit

class CommunicationPageViewController: UIPageViewController {
    // 여러 페이지로 보여줄 뷰 컨트롤러들의 배열
    var viewControllersArray: [UIViewController] = {
         let vc1 = CommunicationListViewController()
         let vc2 = CommunicationListViewController()
         let vc3 = CommunicationListViewController()
         return [vc1, vc2, vc3]
     }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self

        setViewControllers([viewControllersArray[CommunicationData.shared!.currentIndex]], direction: .forward, animated: true)
    }

    func setFirstViewController() {
        // 초기에 표시할 뷰 컨트롤러를 지정합니다. (여기서는 첫 번째 뷰 컨트롤러로 설정합니다.)
        if let firstViewController = viewControllersArray.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension CommunicationPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if CommunicationData.shared!.currentIndex <= 0 {
            CommunicationData.shared!.currentIndex = viewControllersArray.count - 1
            return viewControllersArray[CommunicationData.shared!.currentIndex]
        } else {
            CommunicationData.shared!.currentIndex -= 1
            return viewControllersArray[CommunicationData.shared!.currentIndex]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if CommunicationData.shared!.currentIndex >= viewControllersArray.count - 1 {
            CommunicationData.shared!.currentIndex = 0
            return viewControllersArray[CommunicationData.shared!.currentIndex]
        } else {
            CommunicationData.shared!.currentIndex += 1
            return viewControllersArray[CommunicationData.shared!.currentIndex]
        }
    }
}
