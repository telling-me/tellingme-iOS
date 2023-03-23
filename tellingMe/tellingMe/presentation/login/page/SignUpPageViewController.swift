//
//  LoginPageViewController.swift
//  tellingMe
//
//  Created by 마경미 on 24.03.23.
//

import UIKit

class SignUpPageViewController: UIPageViewController {
    var currentPage = 0

    let viewsList : [UIViewController] = {
        let storyBoard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "agreement")
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "getName")
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "getGender")
        let vc4 = storyBoard.instantiateViewController(withIdentifier: "getBirthday")
        return [vc1, vc2, vc3, vc4]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.dataSource = self
        self.delegate = self
        
        if let firstVC = viewsList.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
//        prevBtn.isEnabled = false
    }
    
    @IBAction func prevAction(_ sender: Any) {
        // 지금 페이지 - 1
        let prevPage = currentPage - 1
        //화면 이동 (지금 페이지에서 -1 페이지로 setView 합니다.)
        self.setViewControllers([viewsList[prevPage]], direction: .reverse, animated: true)
        
        //현재 페이지 잡아주기
        currentPage = self.viewControllers!.first!.view.tag
//        enabledBtn()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        // 지금 페이지 + 1
        let nextPage = currentPage + 1
        //화면 이동 (지금 페이지에서 -1 페이지로 setView 합니다.)
        self.setViewControllers([viewsList[nextPage]], direction: .forward, animated: true)
        
        //현재 페이지 잡아주기
        currentPage = self.viewControllers!.first!.view.tag
//        enabledBtn()
    }
    
//    func enabledBtn() {
//        if currentPage == 0 {
//            prevBtn.isEnabled = false
//        } else if currentPage == 2 {
//            nextBtn.isEnabled = false
//        } else {
//            nextBtn.isEnabled = true
//            prevBtn.isEnabled = true
//        }
//    }
}

extension SignUpPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,previousViewControllers: [UIViewController],transitionCompleted completed: Bool){
        guard completed else { return }
        currentPage = pageViewController.viewControllers!.first!.view.tag
//        enabledBtn()
    }

//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let vcIndex = viewsList.firstIndex(of: viewController) else { return nil }
//        let prevIndex = vcIndex - 1
//        guard prevIndex >= 0 else { return nil }
//        guard viewsList.count > prevIndex else { return nil }
//        return viewsList[prevIndex]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let vcIndex = viewsList.firstIndex(of: viewController) else { return nil }
//        let nextIndex = vcIndex + 1
//        guard nextIndex < viewsList.count else { return nil }
//        guard viewsList.count > nextIndex else { return nil }
//        return viewsList[nextIndex]
//    }
}
