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
    
    public let pages = [GamesViewController.self, JournalViewController.self, HomeViewController.self, LiberationsViewController.self, ResourcesViewController.self] // Array of all pages: Right to Left

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Loads the first page immediately after the pager loads
        setViewControllers([getPage(page: 2)], direction: .forward, animated: false, completion: nil)
        
        // Set dataSource: incorporates the pages
        dataSource = self // Refers to the PageViewController extension of type UIPageViewControllerDataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPage(page: Int) -> UIViewController {
        return storyboard!.instantiateViewController(withIdentifier: "\(pages[page])")
    }
    
    // Sets page control background color to clear
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
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
        
        var i = 0
        while (i < pages.count-2)  {
            if viewController.isKind(of: pages[i]) { // Tests pages to see determine id of current page
                break // Stops looping when identifies page
            } else {
                i += 1 // Increments when not on current page
            }
        }
        
        // Sets new page unless on last page
        if viewController.isKind(of: pages[i]) {
            return getPage(page: i+1)
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // Swiping backward
        
        var i = pages.count-1
        while (i > 1) {
            if viewController.isKind(of: pages[i]) { // Tests pages to see determine id of current page
                break // Stops looping when identifies page
            } else {
                i -= 1 // Increments when not on current page
            }
        }
        
        // Sets new page unless on last page
        if viewController.isKind(of: pages[i]) {
            return getPage(page: i-1)
        } else {
            return nil
        }
    }
    
    // Page control dots
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        // The number of dots in the page control dots
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        // On the first dot when you first load the PageViewController
        // Swift automatically handles switching pages and updating the page control dots
        // Updates when setViewControllers is called
        return 2
    }
}
