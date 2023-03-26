//
//  SignUpViewController.swift
//  tellingMe
//
//  Created by 마경미 on 26.03.23.
//

import UIKit
import GradientProgress

class SignUpViewController: UIViewController {

    @IBOutlet weak var progressBar: GradientProgressBar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    let pages: [UIViewController] = {
        let storyBoard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "agreement")
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "getName")
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "getGender")
        let vc4 = storyBoard.instantiateViewController(withIdentifier: "getBirthday")
        return [vc1, vc2, vc3, vc4]
    }()
    let pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return pageVC
    }()
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setInitUI()
    }

    func setInitUI() {
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
        progressBar.setProgress(1 / Float(pages.count), animated: true)
        progressBar.gradientColors = [  UIColor(red: 0.486, green: 0.937, blue: 0.655, alpha: 1).cgColor,
                                        UIColor(red: 0.561, green: 0.827, blue: 0.957, alpha: 1).cgColor]
        progressBar.layer.cornerRadius = 10
        containerView.addSubview(pageViewController.view)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        if let firstVC = pages.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

    @IBAction func prevAction(_ sender: UIButton) {
        let prevPage = currentPage - 1
        pageViewController.setViewControllers([pages[prevPage]], direction: .reverse, animated: true)
        currentPage = pageViewController.viewControllers!.first!.view.tag
        progressBar.setProgress(Float(currentPage+1) / Float(pages.count), animated: true)
    }

    @IBAction func nextAction(_ sender: UIButton) {
        let nextPage = currentPage + 1
        pageViewController.setViewControllers([pages[nextPage]], direction: .forward, animated: true)
        currentPage = pageViewController.viewControllers!.first!.view.tag
        progressBar.setProgress(Float(currentPage+1) / Float(pages.count), animated: true)
    }

    func enabledBtn() {
        if currentPage == 0 {
            prevButton.isHidden = true
        } else if currentPage == 2 {
        } else {
        }
    }
}

extension SignUpViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        currentPage = pageViewController.viewControllers!.first!.view.tag
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
