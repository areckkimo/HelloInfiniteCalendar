//
//  ViewController.swift
//  HelloSimpleCalendar
//
//  Created by 陳仕偉 on 2021/5/4.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedDate = Date()
    var dates = [Date]()
    let maxDays = 42
    var offsetMonth = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCalendarMonthView()
    }
    
    func setupCalendarMonthView() {
        
        guard let selectedDateByOffsetMonths = CalendarHelper().dateByOffsetMonths(offsetMonth, Of: selectedDate) else {
            return
        }
        
        self.selectedDate = selectedDateByOffsetMonths
        
        guard let beginningMonth = CalendarHelper().firstOfMonth(date: selectedDate),
              let weekDayBeginningMonth = CalendarHelper().weekDay(date: beginningMonth) else {
            return
        }
        
        dates.removeAll()
        
        
        for index in 0..<maxDays {
            let offsetDays = -weekDayBeginningMonth  + index
            guard let date = CalendarHelper().dateByOffsetDays(offsetDays, Of: beginningMonth) else {
                continue
            }
            dates.append(date)
        }
        
        collectionView.reloadData()
    }
}

extension CalendarViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        let date = dates[indexPath.item]
        let calendarHelper = CalendarHelper()
        let selectedMonth = calendarHelper.monthString(date: selectedDate)
        cell.dayLabel.text = CalendarHelper().dayString(date: date)
        
        let dayTextColor: UIColor = calendarHelper.monthString(date: date) == selectedMonth ? .black : .lightGray
        cell.dayLabel.textColor = dayTextColor
        
        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width) / 7
        let height = (collectionView.frame.height) / 7
        return CGSize(width: width, height: height)
    }
}

