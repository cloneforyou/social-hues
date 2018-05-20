//
//  ConvoViewController.swift
//  Social Hues
//
//  Created by Sarah Zhou on  5/19/18
//  Copyright © 2018 Social Hues. All rights reserved.
//

import UIKit

class ConvoPageViewController : UIPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstControl = controllers.first {
             setViewControllers([firstControl],
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
                self.newColoredViewController(order: "Three"),
                self.newColoredViewController(order: "Four"),
                self.newColoredViewController(order: "Five")]
    }()
    
    private func newColoredViewController(order: String) -> UIViewController {
        return UIStoryboard(name: "Convo", bundle: nil).instantiateViewController(withIdentifier:"Convo\(order)")
    }
}

    extension ConvoPageViewController: UIPageViewControllerDataSource {
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
