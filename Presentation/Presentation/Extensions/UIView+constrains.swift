//
//  UIView+constrains.swift
//  MeatStore
//
//  Created by prog_zidane on 6/29/20.
//  Copyright © 2020 Zidane. All rights reserved.
//


import Foundation
import UIKit

public extension UIView{
    @discardableResult
    func widthEqualTo(constant : CGFloat) ->NSLayoutConstraint{
        let generated = widthAnchor.constraint(equalToConstant: constant)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    @discardableResult
    func widthEqualTo(view : UIView,percent : CGFloat) ->NSLayoutConstraint{
        let generated = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: percent)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    
    @discardableResult
    func widthEqualTo(view : UIView,constant : CGFloat = 0) ->NSLayoutConstraint{
        let generated = widthAnchor.constraint(equalTo: view.widthAnchor,constant: constant)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    
    @discardableResult
    func widthEqualOrGreaterThan(constant : CGFloat) ->NSLayoutConstraint{
        let generated = widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    @discardableResult
    func widthEqualOrLesshan(constant : CGFloat) ->NSLayoutConstraint{
        let generated = widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    @discardableResult
    func heightEqualTo(constant : CGFloat) ->NSLayoutConstraint{
        let generated = heightAnchor.constraint(equalToConstant: constant)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    
    @discardableResult
    func heightEqualTo(view : UIView) ->NSLayoutConstraint{
        let generated = heightAnchor.constraint(equalTo: view.widthAnchor,constant : 0)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    @discardableResult
    func heightEqualOrGreaterThan(constant : CGFloat) ->NSLayoutConstraint{
        let generated = heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    
    @discardableResult
    func sizeEqualTo(size : CGSize) -> [NSLayoutConstraint] {
        var array = [NSLayoutConstraint]()
        let widthConstraint = widthAnchor.constraint(equalToConstant: size.width)
        widthConstraint.isActive = true
        let heightConstraint = heightAnchor.constraint(equalToConstant: size.height)
        heightConstraint.isActive = true
        array.append(widthConstraint)
        array.append(heightConstraint)
        translatesAutoresizingMaskIntoConstraints = false
        return array
    }
    
    @discardableResult
    func topEqualTo(constraint : NSLayoutAnchor<NSLayoutYAxisAnchor>,constant : CGFloat = 0) -> NSLayoutConstraint {
        let generated = topAnchor.constraint(equalTo: constraint,constant : constant)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    
    @discardableResult
    func bottomEqualTo(constraint : NSLayoutAnchor<NSLayoutYAxisAnchor>,constant : CGFloat = 0) -> NSLayoutConstraint {
        let generated = bottomAnchor.constraint(equalTo: constraint,constant : constant)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    @discardableResult
    func leadingEqualTo(constraint : NSLayoutAnchor<NSLayoutXAxisAnchor>,constant : CGFloat = 0) -> NSLayoutConstraint {
        let generated = leadingAnchor.constraint(equalTo: constraint,constant : constant)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    
    
    @discardableResult
    func trailingEqualTo(constraint : NSLayoutAnchor<NSLayoutXAxisAnchor>,constant : CGFloat = 0) -> NSLayoutConstraint {
        let generated = trailingAnchor.constraint(equalTo: constraint,constant : constant)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    @discardableResult
    func centerXequalTo(constraint : NSLayoutAnchor<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
        let generated = centerXAnchor.constraint(equalTo: constraint)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    @discardableResult
    func centerYequalTo(constraint : NSLayoutAnchor<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
        let generated = centerYAnchor.constraint(equalTo: constraint)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    func centerEqualTo(view : UIView)  {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func fullSizeEqualTo(view : UIView){
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func fullSizeEqualTo(view : UIView,constant : CGFloat){
        trailingAnchor.constraint(equalTo: view.trailingAnchor,constant : -constant).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor,constant : constant).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor,constant : constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor,constant : -constant).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func fullSizeEqualTo(view : UIView,horizontalMa : CGFloat,verticalMa: CGFloat){
        trailingAnchor.constraint(equalTo: view.trailingAnchor,constant : -horizontalMa).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor,constant : horizontalMa).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor,constant : verticalMa).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor,constant : -verticalMa).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @discardableResult
    func horizontalEqualTo(view : UIView,constant : CGFloat = 0)  -> (NSLayoutConstraint , NSLayoutConstraint){
        let trail = trailingAnchor.constraint(equalTo: view.trailingAnchor,constant : -constant)
        let lead = leadingAnchor.constraint(equalTo: view.leadingAnchor,constant : constant)
        trail.isActive = true
        lead.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return (lead , trail)
    }
    
    func verticalEqualTo(view : UIView,constant : CGFloat = 0){
        topAnchor.constraint(equalTo: view.topAnchor,constant : constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor,constant : -constant).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func fillSuperview(constant : CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor,constant : constant).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor,constant : -constant).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor,constant : constant).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor,constant : -constant).isActive = true
        }
    }
    
    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
    
    @discardableResult
    func heightEqualToPercentTo(view : UIView,percent : CGFloat) ->NSLayoutConstraint{
        let generated = heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: percent)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    @discardableResult
    func widthEqualToPercentTo(view : UIView,percent : CGFloat) ->NSLayoutConstraint{
        let generated = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: percent)
        generated.isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        return generated
    }
    
    func setCornerToHalf(){
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    func setCornerTo(corner: CGFloat){
        layer.cornerRadius = corner
        clipsToBounds = true
    }
    
    func maskedRoundedCorners(corners: [Corner], amount: CGFloat = 5) {
        layer.cornerRadius = amount
        let maskedCorners: CACornerMask = CACornerMask(rawValue: createMask(corners: corners))
        layer.maskedCorners = maskedCorners
    }
    
    private func createMask(corners: [Corner]) -> UInt {
        return corners.reduce(0, { (a, b) -> UInt in
            return a + parseCorner(corner: b).rawValue
        })
    }
    
    private func parseCorner(corner: Corner) -> CACornerMask.Element {
        let corners: [CACornerMask.Element] = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        return corners[corner.rawValue]
    }
    
    enum Corner:Int {
        case bottomRight = 0,
        topRight,
        bottomLeft,
        topLeft
    }
}

// MARK: - Properties

public extension UIView {
    
    /// Size of view.
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    /// Width of view.
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    /// Height of view.
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    internal var perfectRoundValue: CGFloat {
        return bounds.maxX / 6
    }
    
    func round_Corners(withcorners corners: UIRectCorner = [.allCorners], radius: CGFloat? = 0) {
        DispatchQueue.main.async {
            let maskPath1 = UIBezierPath(roundedRect: self.bounds,
                                         byRoundingCorners: corners,
                                         cornerRadii: CGSize(width: radius ?? self.perfectRoundValue, height: radius ?? self.perfectRoundValue))
            let maskLayer1 = CAShapeLayer()
            maskLayer1.frame = self.bounds
            maskLayer1.path = maskPath1.cgPath
            self.layer.mask = maskLayer1
            self.layoutIfNeeded()
        }
    }
}
public extension UIView
{
    func dashedBorder(color: UIColor = Colors.primary.color){
        let layer = CAShapeLayer()
        layer.strokeColor = color.cgColor
        layer.lineDashPattern = [3, 3]
        layer.frame = self.bounds
        layer.fillColor = nil
        layer.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(layer)
    }
    
    func shake() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else {return}
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.1
            animation.repeatCount = 3
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x + 6, y: self.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x - 6, y: self.center.y))
            self.layer.add(animation, forKey: "position")
        }
    }
}
