//
//  UIView+Constants.swift
//  DishBookIOS
//
//  Created by Denys Danyliuk on 04.05.2021.
//

import UIKit

extension UIView {
    
    func addSubview(_ other: UIView, constraints: [NSLayoutConstraint]) {
        
        addSubview(other)
        other.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    func addSubview(_ other: UIView, withEdgeInsets edgeInsets: UIEdgeInsets) {
        
        addSubview(other, constraints: [
            other.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInsets.left),
            other.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top),
            other.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -edgeInsets.right),
            other.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -edgeInsets.bottom)
        ])
    }
    
    func addSubviewToCenter(_ other: UIView, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        var constraints = [
            other.centerYAnchor.constraint(equalTo: centerYAnchor),
            other.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        width.flatMap { other.widthAnchor.constraint(equalToConstant: $0) }.map { constraints.append($0) }
        height.flatMap { other.heightAnchor.constraint(equalToConstant: $0) }.map { constraints.append($0) }
        
        addSubview(other, constraints: constraints)
    }
    
    func insertSubview(_ other: UIView, belowSubview: UIView, constraints: [NSLayoutConstraint]) {
        
        insertSubview(other, belowSubview: belowSubview)
        other.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    func insertSubview(_ other: UIView, aboveSubview: UIView, constraints: [NSLayoutConstraint]) {
        
        insertSubview(other, aboveSubview: aboveSubview)
        other.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    func insertSubview(_ other: UIView, index: Int, constraints: [NSLayoutConstraint]) {
        
        insertSubview(other, at: index)
        other.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
