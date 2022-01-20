//
//  UIView.swift
//  FinalProject
//
//  Created by loujain on 15/01/2022.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
