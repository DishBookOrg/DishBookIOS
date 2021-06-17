//
//  ShadowedView.swift
//  DishBookIOS
//
//  Created by Anastasia Holovash on 16.06.2021.
//

import UIKit

class ShadowedView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 71 / 255, alpha: 1.0).cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = .init(width: 0, height: 24)
            shadowLayer.shadowOpacity = 0.16
            shadowLayer.shadowRadius = 32
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
