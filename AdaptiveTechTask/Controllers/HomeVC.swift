//
//  HomeVC.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    let coursesCellIdentifier = "CoursesCell"
    let homeToPDFSegueIdentifier = "HomeToDisplayPDFSegue"
    
    @IBOutlet weak var tableView: UITableView!
    var selectedcourseInfo: (name: String, url: String)?
    
    var coursesList = [CoursesListResponseJSON](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIHelper.initNavigationBar(self, barStyle: .black)
        getAllCourses()
        // Do any additional setup after loading the view.
    }
    
    func getAllCourses(){
        if Connection.isConnected(){
            self.startLoading()
            CoursesListModel.getCourses { (isSucceeded, results, error, statusCode) in
                self.stopLoading()
                if isSucceeded!{
                    guard let coursesList = results else{
                        self.showAlertForError(ErrorTypes.ErrorType.UnknownError)
                        return}
                    self.coursesList = coursesList
                }else{
                    self.showAlertForError(ErrorTypes.ErrorType.UnknownError)
                }
            }
        }else{
            self.showAlertForConnection()
        }
    }
    
    @IBAction func logOutAction(_ sender: UIBarButtonItem) {
        UserManager.isRegistered = false
        self.goToLogInVC()
    }
    
    func goToLogInVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logInVC = storyboard.instantiateViewController(withIdentifier: "LogInVC")
        logInVC.modalTransitionStyle = .crossDissolve
        self.present(logInVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let displayPdfVC = segue.destination as? DisplayPDFVC{
            displayPdfVC.selectedcourseInfo = selectedcourseInfo
        }
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate, CoursesCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: coursesCellIdentifier) as! CoursesCell
        cell.delegate = self
        cell.course = coursesList[indexPath.row]
        return cell
    }
    
    func didTapOpenPDFWith(link: String, courseName: String) {
        let data = (name: courseName, url: link)
        selectedcourseInfo = data
        self.performSegue(withIdentifier: homeToPDFSegueIdentifier, sender: nil)
    }
}
