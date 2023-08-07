//
//  CIImage+Extension.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/19.
//

import Foundation
import UIKit

extension CIImage {
    
    func convert() -> UIImage
    {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(self, from: self.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
}


extension UIImage {
    
    func renderResizedImage (newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        let image = renderer.image { (context) in
            self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        }
        return image
    }
    
}
