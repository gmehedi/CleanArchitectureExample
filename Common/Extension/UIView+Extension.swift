//
//  UIView+Extension.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/19.
//

import Foundation
import UIKit

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func showActivityIndicator() {
        self.addSubview(loaderView)
    }
    
    func customAnimationWith(wR: CGFloat, hR: CGFloat) {
        
        UIView.animate(withDuration: 0.15, delay: 0, animations: {
            self.transform = CGAffineTransform(scaleX: wR, y: hR)
            self.alpha = 0.5
            self.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.15, delay: 0.15, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.alpha = 1.0
            self.layoutIfNeeded()
        })
        
    }
    
}

extension UIScrollView {
    
    func subViewArea() -> CGSize {
        var rect = CGRect.zero
        for subview in subviews {
            rect = rect.union(subview.frame)
        }
        return rect.size
    }
}

extension UIView {
    
    func takeScreenshot(of view: UIView) -> UIImage? {
        autoreleasepool {
            // Calculate the transformed frame of the view
            let transformedFrame = view.bounds.applying(view.transform)
            
            // Create a graphics context with the transformed view's frame
            UIGraphicsBeginImageContextWithOptions(transformedFrame.size, false, 0.5)
            
            // Translate the graphics context to match the transformed view's origin
            let context = UIGraphicsGetCurrentContext()!
            context.translateBy(x: -transformedFrame.origin.x, y: -transformedFrame.origin.y)
            
            // Apply the view's transform to the graphics context
            view.layer.render(in: context)
            
            // Get the screenshot image from the graphics context
            let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
            
            // End the graphics context
            UIGraphicsEndImageContext()
            
            return screenshotImage
        }
    }
    
    
    func captureScreenshotOfLongView(view: UIView, contentSize: CGSize, scaledSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        
        let scaleY = scaledSize.height / contentSize.height
        
        view.transform = CGAffineTransform(scaleX: scaleY, y: scaleY)
        let output = view.takeScreenshot(of: view)
        
        view.transform = .identity
        completion(output)
    }
    
}

