//
//  PageViewController.swift
//  HelloInfiniteCalendar
//
//  Created by 陳仕偉 on 2021/5/6.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self

        guard let calendarViewController = setupCalendarViewController(page: currentPage) else {
            return
        }
        self.setViewControllers([calendarViewController], direction: .forward, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshView()
    }
    
    func setupCalendarViewController(page: Int) -> CalendarViewController?{
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let calendarPage = storyboard.instantiateViewController(identifier: "CalendarViewController") as? CalendarViewController else {
            return nil
        }
        calendarPage.offsetMonth = page
        return calendarPage
    }
    
    func refreshView(){
        guard let currentCalendarViewController = viewControllers?.first as? CalendarViewController,
              let mainViewController = parent as? MainViewController else{
            return
        }
        let selectedDate = currentCalendarViewController.selectedDate
        let year = CalendarHelper().yearString(date: selectedDate)
        let month = CalendarHelper().monthString(date: selectedDate)
        mainViewController.dateLabel.text = "\(year)年\(month)月"
        
        self.currentPage = currentCalendarViewController.offsetMonth
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //swap to previous month
        return setupCalendarViewController(page: currentPage - 1)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //swap to next month
        return setupCalendarViewController(page: currentPage + 1)
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            refreshView()
        }
    }
}

extension PageViewController {
    func goToNextPage() {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        refreshView()
    }
    func goToPreviousPage() {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
        refreshView()
    }
}
