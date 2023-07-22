//
//  SignUpPageViewController.swift
//  tellingMe
//
//  Created by 마경미 on 27.03.23.
//

import UIKit

class SignUpPageViewController: UIPageViewController {
    let viewModel = SignUpPaveViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        if let firstVC = viewModel.pages.first {
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
    func prevPage() {
        let viewController = self.parent as? SignUpViewController
        self.viewModel.currentIndex -= 1
        if self.viewModel.currentIndex != 2 {
            viewController?.setSkipButtonHidden()
        } else {
            viewController?.setSkipButtonUnhidden()
        }
        setViewControllers([viewModel.pages[viewModel.currentIndex]], direction: .reverse, animated: true, completion: nil)
        viewController?.setProgress(with: Float(viewModel.currentIndex)/Float(viewModel.pagesCount))
    }
    func nextPage() {
        let viewController = self.parent as? SignUpViewController
        self.viewModel.currentIndex += 1
        if self.viewModel.currentIndex != 2 {
            viewController?.setSkipButtonHidden()
        } else {
            viewController?.setSkipButtonUnhidden()
        }
        setViewControllers([viewModel.pages[viewModel.currentIndex]], direction: .forward, animated: true, completion: nil)
        viewController?.setProgress(with: Float(viewModel.currentIndex)/Float(viewModel.pagesCount))
     }
}
