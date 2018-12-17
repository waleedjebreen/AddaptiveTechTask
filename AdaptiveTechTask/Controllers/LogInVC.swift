//
//  LogInVC.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTF: TweeAttributedTextField!
    @IBOutlet weak var passwordTF: TweeAttributedTextField!
    @IBOutlet weak var logInBtn: UIButtonX!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInAction(_ sender: UIButton) {
        guard let username = usernameTF.text, usernameTF.text != "" else {
            presentErrorWith(message: "Username Is Empty!")
            usernameTF.makeWarningWith(message: "Username Is Empty!", bool: true)
            return
        }
        guard let password = passwordTF.text, passwordTF.text != "" else {
            presentErrorWith(message: "Password Is Empty!")
            passwordTF.makeWarningWith(message: "Password Is Empty!", bool: true)
            return
        }
        usernameTF.makeWarningWith(message: "", bool: false)
        passwordTF.makeWarningWith(message: "", bool: false)
        doLogIn(userName: username, password: password)
    }
    
    func doLogIn(userName: String, password: String){
        if Connection.isConnected(){
            self.stopLoading()
            LogInModel.logInUserWith(userName: userName, password: password) { (isSucceeded, response, error, statusCode) in
                self.stopLoading()
                if isSucceeded!{
                    UserManager.isRegistered = true
                    self.goToHome()
                }else{
                    self.presentErrorWith(message: "Username Or Password Is Incorrect, Please Try Again !")
                }
            }
        }else{
            self.showAlertForConnection()
        }
    }
    
    func goToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeNav")
        homeVC.modalTransitionStyle = .crossDissolve
        self.present(homeVC, animated: true, completion: nil)
    }
    
    func presentErrorWith(message: String){
        let alertController = UIHelper.oneActionAlert(alertTitle: "Addaptive TechSoft", alertMessage: message, firstAction: "OK", firstStyle: .default, alertStyle: .alert) {}
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - KeyBoard Apperance
    @objc func keyboardWillShow(_ notification:Notification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: view.window)
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
    }
    
    @objc func scrollViewTapped(){
        view.endEditing(true)
    }
    
    //MARK:- init UI
    func initUI(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
        
        let scrollViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.scrollViewTapped))
        scrollView.isUserInteractionEnabled = true
        scrollView.addGestureRecognizer(scrollViewTapGesture)
    }
}

extension LogInVC: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SharedElementTransitionAnimator(type: .present)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SharedElementTransitionAnimator(type: .dismiss)
    }
}

extension LogInVC: CustomTransitionDestination {
    var toAnimatedSubviews: [UIView] { return [logoImg] }
}
extension LogInVC: CustomTransitionOriginator {
    var fromAnimatedSubviews: [UIView] { return [logoImg] }
}
