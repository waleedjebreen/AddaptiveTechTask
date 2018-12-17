//
//  UIHelper.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class UIHelper{
    //MARK:- Alerts
    static func oneActionAlert(alertTitle title: String,alertMessage message: String, firstAction firstStr: String, firstStyle: UIAlertAction.Style, alertStyle: UIAlertController.Style, firstActionHandler: @escaping () -> Void) -> UIAlertController{
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let firstAction = UIAlertAction(title: firstStr, style: firstStyle) { (action:UIAlertAction!) in
            firstActionHandler()
        }

        alertController.addAction(firstAction)
        
        return alertController
        
    }
    
    static func twoActionsAlert(alertTitle title: String,alertMessage message: String, firstAction firstStr: String, firstStyle: UIAlertAction.Style, secondAction secondStr: String, secondStyle: UIAlertAction.Style, alertStyle: UIAlertController.Style, firstActionHandler: @escaping () -> Void, secondActionHandler: @escaping () -> Void) -> UIAlertController{
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let firstAction = UIAlertAction(title: firstStr, style: firstStyle) { (action:UIAlertAction!) in
            firstActionHandler()
        }
        
        let secondAction = UIAlertAction(title: secondStr, style: secondStyle) { (action:UIAlertAction!) in
            secondActionHandler()
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        
        return alertController
        
    }
    
    static func threeActionsAlert(alertTitle title: String,alertMessage message: String, firstAction firstStr: String, firstStyle: UIAlertAction.Style, secondAction secondStr: String, secondStyle: UIAlertAction.Style, thirdAction thirdStr: String, thirdStyle: UIAlertAction.Style, alertStyle: UIAlertController.Style, firstActionHandler: @escaping () -> Void, secondActionHandler: @escaping () -> Void, thirdActionHandler: @escaping () -> Void) -> UIAlertController{
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let firstAction = UIAlertAction(title: firstStr, style: firstStyle) { (action:UIAlertAction!) in
            firstActionHandler()
        }
        
        let secondAction = UIAlertAction(title: secondStr, style: secondStyle) { (action:UIAlertAction!) in
            secondActionHandler()
        }
        
        let thirdAction = UIAlertAction(title: thirdStr, style: thirdStyle) { (action:UIAlertAction!) in
            thirdActionHandler()
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(thirdAction)
        
        return alertController
        
    }
    
    //MARK:- Pop Ups
    static func makePopUp(popoverContent: UIViewController, currentController: UIViewController, currentDelegate: UIPopoverPresentationControllerDelegate) -> UINavigationController{
        let navigationController = UINavigationController(rootViewController: popoverContent)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        navigationController.isNavigationBarHidden = true
        
        let popover = navigationController.popoverPresentationController
        popoverContent.preferredContentSize = CGSize(width: currentController.view.frame.width, height: currentController.view.frame.height*0.4)
        popover?.sourceView?.isUserInteractionEnabled = true
        popover?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        popover?.delegate = currentDelegate
        popover?.sourceView = currentController.view
        popover?.sourceRect = CGRect(x: UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY,width: 0,height: 0)
        
        return navigationController
    }
    
    //MARK:- Animations
    static func circleAnimation(_ view: UIView){
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            
            view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        })
        UIView.animate(withDuration: 2.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
            
            view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        }, completion: nil)
        
    }
    
    static func pulseAnimation(_ view: UIView){
        view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 10.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        view.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  })
    }
    
    static func shakeAnimation(_ view: UIView){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }
    
    static func fadeInAnimation(_ view: UIView, delay late: TimeInterval){
        view.alpha = 0.0
        UIView.animate(withDuration: 0.5, delay: late, options: UIView.AnimationOptions.curveEaseIn, animations: {
            view.alpha = 1.0
        }, completion: {(finished:Bool) in
            
        })
    }
    //MARK:- Navigation Bar
    static func initNavigationBarWithTitle(_ view: UIViewController, barStyle: UIBarStyle, _ title:String, textSize: Int = 17){
        let image = UIImage()
        view.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        view.navigationController?.navigationBar.shadowImage = UIImage()
        let backItem = UIBarButtonItem()
        backItem.title = ""
        view.navigationItem.backBarButtonItem = backItem
        
        view.navigationController?.navigationBar.barTintColor = Colors.applicationThemeColor
        view.navigationController?.navigationBar.isTranslucent = false
        view.navigationController?.navigationBar.barStyle = barStyle
        
        view.navigationController?.navigationBar.tintColor = UIColor.white
        view.navigationItem.title = title
        let titleDict = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: FontNames.MissionGothicRegular, size: CGFloat(textSize))!]
        view.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        let barButtonTitleDict = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: FontNames.MissionGothicRegular, size: 17)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonTitleDict, for: UIControl.State.normal)
    }
    
    static func initNavigationBar(_ view: UIViewController, barStyle: UIBarStyle, textSize: Int = 17){
        let image = UIImage()
        view.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        view.navigationController?.navigationBar.shadowImage = UIImage()
        let backItem = UIBarButtonItem()
        backItem.title = ""
        view.navigationItem.backBarButtonItem = backItem
        
        view.navigationController?.navigationBar.barTintColor = Colors.applicationThemeColor
        view.navigationController?.navigationBar.isTranslucent = false
        view.navigationController?.navigationBar.barStyle = barStyle
        
        view.navigationController?.navigationBar.tintColor = UIColor.white
        let titleDict = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: FontNames.MissionGothicRegular, size: CGFloat(textSize))!]
        view.navigationController?.navigationBar.titleTextAttributes = titleDict
        
        let barButtonTitleDict = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: FontNames.MissionGothicRegular, size: 17)!]
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonTitleDict, for: UIControl.State.normal)
    }
    
    //MARK:- Date
    static func makeDatePicker() -> UIDatePicker{
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian);
        let todayDate = Date()
        let components = (calendar as NSCalendar?)?.components([NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day], from: todayDate)
        let minimumYear = (components?.year)! - 1950
        let minimumMonth = (components?.month)! - 1
        let minimumDay = (components?.day)! - 1
        
        var comps = DateComponents();
        comps.year = -minimumYear
        comps.month = -minimumMonth
        comps.day = -minimumDay
        
        let minDate = (calendar as NSCalendar?)?.date(byAdding: comps, to: todayDate, options: NSCalendar.Options.init(rawValue: 0))
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.minimumDate = minDate
        datePickerView.maximumDate = todayDate
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        
        return datePickerView
    }
    
    static func datePickerFormatter() -> DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.locale = Locale(identifier: "en_MU")
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "MM/dd/yyy"
        
        return dateFormatter
    }
    //MARK:- ToolBar
    static func makeToolBar(title: String, vc: UIViewController, selector: Selector) -> UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.barTintColor = Colors.applicationThemeColor
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: title, style: UIBarButtonItem.Style.plain, target: vc, action: selector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}
//MARK:- Extentions
//MARK:- UIView Extention
extension UIView {
    
    func slideInFromLeft(_ duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        
        let slideInFromLeftTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func slideInFromRight(_ duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromRightTransition.type = CATransitionType.push
        slideInFromRightTransition.subtype = CATransitionSubtype.fromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromRightTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
}
//MARK:- NSDate Extention
extension NSDate {
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}
//MARK:- UIPageViewController Extention
extension UIPageViewController{
    func goToNextPage(){
        
        guard let currentViewController = self.viewControllers?.first else { return }
        
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }
}
//MARK:- CGFloat Extention
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
//MARK:- UIColor Extention
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.contentOffset = CGPoint(x: 0,y: childStartPoint.y - 40)
        }
    }
}

extension UIViewController{
    func showAlertForConnection(){
        let title = "No Internet Connection"
        let message = "Please Connect To The Internet To Continue"
        let done = "Done"
        let alertController = UIHelper.oneActionAlert(alertTitle: title, alertMessage: message, firstAction: done, firstStyle: .default, alertStyle: .alert) {}
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertForError(_ error: ErrorTypes.ErrorType){
        //This Shows A Message Based On The Passed Error
        let title = "Something Went Wrong!"
        let message = "Please Try Again Later \(error)"
        let done = "Done"
        
        let alertController = UIHelper.oneActionAlert(alertTitle: title, alertMessage: message, firstAction: done, firstStyle: .default, alertStyle: .alert) {}
        self.present(alertController, animated: true, completion: nil)
    }

    func startLoading(){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.isUserInteractionEnabled = true
        hud.label.text = "Loading..."
        hud.label.textColor = .white
        hud.contentColor = .white
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        hud.backgroundColor = .clear
        hud.animationType = .fade
    }
    
    func stopLoading(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
