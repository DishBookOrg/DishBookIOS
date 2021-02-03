//
//  UIView+Anchors.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 03.02.2021.
//

import UIKit

extension UIView {
    
    public func fillSuperview() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    @discardableResult
    public func anchor(top: NSLayoutYAxisAnchor? = nil,
                       topConstant: CGFloat = 0,
                       bottom: NSLayoutYAxisAnchor? = nil,
                       bottomConstant: CGFloat = 0,
                       left: NSLayoutXAxisAnchor? = nil,
                       leftConstant: CGFloat = 0,
                       right: NSLayoutXAxisAnchor? = nil,
                       rightConstant: CGFloat = 0,
                       widthConstant: CGFloat = 0,
                       heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach { $0.isActive = true }
        
        return anchors
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    @discardableResult
    public func anchorCenterY(to view: UIView) -> NSLayoutConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        let anchor = centerYAnchor.constraint(equalTo: view.centerYAnchor)
        anchor.isActive = true
        return anchor
    }
    
    @discardableResult
    public func anchorCenterX(to view: UIView) -> NSLayoutConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        let anchor = centerXAnchor.constraint(equalTo: view.centerXAnchor)
        anchor.isActive = true
        return anchor
    }
    
    public func anchorCenterSuperview() {
        
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
}
