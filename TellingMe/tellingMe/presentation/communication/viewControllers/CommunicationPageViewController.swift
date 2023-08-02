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

        vc1.index = 0
        vc1.question = CommunicationData.shared!.threeDays[0]

        vc2.index = 1
        vc2.question = CommunicationData.shared!.threeDays[1]

        vc3.index = 2
        vc3.question = CommunicationData.shared!.threeDays[2]
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
        guard let index = viewControllersArray.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = (index - 1 + viewControllersArray.count) % viewControllersArray.count
        CommunicationData.shared!.currentIndex = previousIndex
        return viewControllersArray[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersArray.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = (index + 1) % viewControllersArray.count
        CommunicationData.shared!.currentIndex = nextIndex
        return viewControllersArray[nextIndex]
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return CommunicationData.shared!.currentIndex
    }
}

extension CommunicationPageViewController {
    func prevPage() {
        setViewControllers([self.viewControllersArray[CommunicationData.shared!.currentIndex]], direction: .forward, animated: true, completion: nil)
    }
    func nextPage() {
        setViewControllers([self.viewControllersArray[CommunicationData.shared!.currentIndex]], direction: .forward, animated: true, completion: nil)
     }
}
