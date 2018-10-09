//
//  PageViewController.swift
//  REMOLD
//
//  Created by Mingyoung J. Jeng 02 on 10/9/18.
//  Copyright © 2018 CAPS. All rights reserved.
//

// http://khou22.com/ios/2016/06/28/making-a-simple-page-based-application-in-swift.html

import UIKit

class PageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Loads the first page immediately after the pager loads
        setViewControllers([getPageOne()], direction: .forward, animated: false, completion: nil)
        
        // Set dataSource: incorporates the pages
        dataSource = self // Refers to the PageViewController extension of type UIPageViewControllerDataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPageOne() -> OneViewController {
        // Retrieve the view
        return storyboard!.instantiateViewController(withIdentifier: "OneViewController") as! OneViewController
    }
    
    func getPageTwo() -> TwoViewController {
        // Retrieve page two
        return storyboard!.instantiateViewController(withIdentifier: "TwoViewController") as! TwoViewController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // Swiping forward
        
        if viewController.isKind(of: OneViewController.self) { // If you're on page one
            // We want to swipe to page two
            return getPageTwo()
        } else { // If on page two
            // End of all pages
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // Swiping backward
        
        if viewController.isKind(of: TwoViewController.self) {
            // If on page two, can swipe back to page one
            return getPageOne()
        } else {
            // If on the first page, can't swipe back
            return nil
        }
    }
    
    // Page control dots
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        // The number of dots in the page control dots
        return 2
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        // On the first dot when you first load the PageViewController
        // Swift automatically handles switching pages and updating the page control dots
        // Updates when setViewControllers is called
        return 0
    }
}
