//
//  CustomButton.swift
//  calculator
//
//  Created by rdec 3 on 24/01/18.
//  Copyright © 2018 rdec 3. All rights reserved.
//

import UIKit
@IBDesignable
class CustomButton: UIButton {
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = min(frame.size.width, frame.size.height) / 2
        self.clipsToBounds = true
        
    }

}
