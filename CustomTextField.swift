//
//  CustomTextField.swift
//  DesidimeApp
//
//  Created by PCPL 41 on 4/11/17.
//  Copyright © 2017 PCPL 41. All rights reserved.
//

import UIKit


class CustomTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Add a bottomBorder.
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: CGFloat(10.0), y: CGFloat(frame.size.height - 1), width: CGFloat(frame.size.width - 10), height: CGFloat(1.0))
        bottomBorder.backgroundColor = UIColor.red.cgColor
        layer.addSublayer(bottomBorder)
        autocorrectionType = .no
    }
    // MARK: - setters
    
    func setLeftViewImage(_ leftViewImage: UIImage) {
        let viwLeft = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(40), height: CGFloat(40)))
        let imgviwLeftView = UIImageView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(25), height: CGFloat(25)))
        viwLeft.backgroundColor = UIColor.clear
        viwLeft.addSubview(imgviwLeftView)
        imgviwLeftView.center = viwLeft.center
        imgviwLeftView.image = leftViewImage
        leftViewMode = .always
        leftView = viwLeft
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
}
