//
//  OnboardPageViewController.swift
//  Social Hues
//
//  Created by Daniel Kim on 5/17/18.
//  Copyright © 2018 Social Hues. All rights reserved.
//

import UIKit

// OnboardPageView Controller controls the onboarding pages found in the Onboarding storyboard
class OnboardPageViewController : UIPageViewController {
    

//    @IBAction func getStarted(_ sender: UIButton) {
//        //let storyboard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle:nil)
//        let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
//        self.present(signupVC, animated: true, completion: nil)
//        //setViewControllers([signupVC], direction: .forward, animated: true)
//        //self.navigationController.pushViewController(secondViewController, animated: true)
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = controllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    // The three view controllers referred by their names
    private(set) lazy var controllers: [UIViewController] = {
        return [self.newColoredViewController(order: "One"),
                self.newColoredViewController(order: "Two"),
                self.newColoredViewController(order: "Three")]
    }()
    
    private func newColoredViewController(order: String) -> UIViewController {
        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier:"Onboard\(order)")
    }
}

extension OnboardPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = controllers.index(of:viewController) else {
            return nil
        }
        let prevIndex = vcIndex - 1
        
        guard prevIndex >= 0 else {
            return nil
        }
        
        guard controllers.count > prevIndex else {
            return nil
        }
        
        return controllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = controllers.index(of:viewController) else {
            return nil
        }
        let nextIndex = vcIndex + 1
        
        guard nextIndex != controllers.count else {
            return nil
        }
        
        guard controllers.count > nextIndex else {
            return nil
        }
        
        return controllers[nextIndex]
    }
    
    
    
}
