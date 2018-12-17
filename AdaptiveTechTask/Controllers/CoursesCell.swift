//
//  CoursesCell.swift
//  AdaptiveTechTask
//
//  Created by Waleed Jebreen on 12/17/18.
//  Copyright © 2018 AdaptiveTech. All rights reserved.
//

import UIKit
import Kingfisher

protocol CoursesCellDelegate {
    func didTapOpenPDFWith(link: String, courseName: String)
}

class CoursesCell: UITableViewCell {
    
    var delegate: CoursesCellDelegate?
    
    var course: CoursesListResponseJSON?{
        didSet{
            if let name = course?.couseName{
                nameLbl.text = name
            }else{
                nameLbl.text = ""
            }
            
            if let description = course?.couseDesc{
                descriptionLbl.text = description
            }else{
                descriptionLbl.text = ""
            }
            
            if let imageUrl = course?.couseImage{
                if let url = URL(string: imageUrl){
                    courseImg.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "AtsIcon"), options: nil, progressBlock: nil, completionHandler: nil)
                }else{
                    courseImg.image = #imageLiteral(resourceName: "AtsIcon")
                }
            }else{
                courseImg.image = #imageLiteral(resourceName: "AtsIcon")
            }
            
            if let _ = course?.pdfURL{
                openPDFBtn.isHidden = false
            }else{
                openPDFBtn.isHidden = true
            }
        }
    }
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var openPDFBtn: UIButtonX!
    @IBOutlet weak var courseImg: UIImageView!
    
    @IBAction func openPDFAction(_ sender: UIButton) {
        guard let courseName = course?.couseName else{return}
        guard let pdfLink = course?.pdfURL else{return}
        delegate?.didTapOpenPDFWith(link: pdfLink, courseName: courseName)
    }
}
