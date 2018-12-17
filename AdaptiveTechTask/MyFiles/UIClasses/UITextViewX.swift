//
//  UITextViewX.swift
//  MAISON GLAMOUR BP
//
//  Created by Waleed Jebreen on 1/8/18.
//  Copyright © 2018 Mozaicis. All rights reserved.
//

import UIKit

@IBDesignable
class UITextViewX: UITextView {

    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    // MARK: - Corner Radius
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
