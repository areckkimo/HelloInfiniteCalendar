//
//  MainViewController.swift
//  HelloInfiniteCalendar
//
//  Created by 陳仕偉 on 2021/5/6.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    var pageViewController: PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextMonthOnPressedButton(_ sender: UIButton) {
        pageViewController?.goToNextPage()
    }
    
    @IBAction func previousMonthOnPressedButton(_ sender: UIButton) {
        pageViewController?.goToPreviousPage()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let pageVC = segue.destination as? PageViewController,
           segue.identifier == "pageVCEmbedSegue" {
            self.pageViewController = pageVC
        }
    }

}
