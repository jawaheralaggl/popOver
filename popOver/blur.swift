//
//  blur.swift
//  popOver
//
//  Created by Jawaher Alagel on 9/5/20.
//  Copyright © 2020 Jawaher Alaggl. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func blurView(style: UIBlurEffect.Style) {
        var blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: style)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        
        addSubview(blurEffectView)
    }
    
    func removeBlur() {
        for view in self.subviews {
            if let view = view as? UIVisualEffectView {
                view.removeFromSuperview()
            }
        }
    }
    
}
