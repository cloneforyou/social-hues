//
//  ConvoViewController.swift
//  Social Hues
//
//  Created by Sarah Zhou on  5/19/18
//  Copyright © 2018 Social Hues. All rights reserved.
//

import UIKit

protocol ConvoPageViewControllerDelegate: class {
    func userDidFinishOnBoard()
}

class ConvoPageViewController : UIPageViewController {
    weak var detailsDelegate: DetailsBeforeDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstControl = controllers.first {
             setViewControllers([firstControl],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        self.view.backgroundColor = .gray
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
                self.newColoredViewController(order: "Four")]
    }()
    
    private func newColoredViewController(order: String) -> UIViewController {
        let newVC = UIStoryboard(name: "ConvoOnboard", bundle: nil).instantiateViewController(withIdentifier:"Convo\(order)") as! ConvoScreenViewController
        newVC.delegate = self
        return newVC
    }
}

extension ConvoPageViewController: ConvoPageViewControllerDelegate {
    func userDidFinishOnBoard() {
        self.dismiss(animated: false, completion: nil)
        self.detailsDelegate?.startPrompts()
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
