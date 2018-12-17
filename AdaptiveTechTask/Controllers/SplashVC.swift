//
//  SplashVC.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    @IBOutlet weak var logoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoImg.transform = CGAffineTransform(translationX: 0, y: 70)
        self.logoImg.alpha = 0.0
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLogoAndProcceed()
    }
    
    func animateLogoAndProcceed(){
        UIView.animate(withDuration: 1, animations: {
            self.logoImg.alpha = 1
            self.logoImg.transform = .identity
        }) { (complition) in
            if UserManager.isRegistered{
                self.goToHome()
            }else{
                self.goToLogInVC()
            }
        }
    }
    
    func goToHome(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeNav")
        homeVC.modalTransitionStyle = .crossDissolve
        self.present(homeVC, animated: true, completion: nil)
    }
    
    func goToLogInVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logInVC = storyboard.instantiateViewController(withIdentifier: "LogInVC")
        logInVC.transitioningDelegate = self
        self.present(logInVC, animated: true, completion: nil)
    }
}

extension SplashVC: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SharedElementTransitionAnimator(type: .present)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SharedElementTransitionAnimator(type: .dismiss)
    }
}

extension SplashVC: CustomTransitionOriginator {
    var fromAnimatedSubviews: [UIView] { return [logoImg] }
}

extension SplashVC: CustomTransitionDestination {
    var toAnimatedSubviews: [UIView] { return [logoImg] }
}
