//
//  SignUpPageViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

class SignUpPageViewController: UIPageViewController {
    let pages: [UIViewController] = {
        let storyBoard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "agreement")
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "getName")
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "getGender")
        let vc4 = storyBoard.instantiateViewController(withIdentifier: "getBirthday")
        return [vc1, vc2, vc3, vc4]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension SignUpPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}

extension SignUpPageViewController {
    func prevPageWithIndex(index: Int) {
        setViewControllers([pages[index]], direction: .reverse, animated: true, completion: nil)
        let viewController = self.parent as? SignUpViewController
        viewController?.setProgress(with: Float(index)/Float(pages.count))
    }
    func nextPageWithIndex(index: Int) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
        let viewController = self.parent as? SignUpViewController
        viewController?.setProgress(with: Float(index)/Float(pages.count))
     }
}
