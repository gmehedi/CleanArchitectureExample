//
//  String+Extension.swift
//  ChatGPTiOS
//
//  Created by M M Mehedi Hasan on 2023/07/16.
//

import UIKit


extension String {
    
    func localization() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

extension String {
    
    func SizeOf(_ font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        //guard self.hasPrefix(prefix) else { return self }
        let numberOfItemShouldRemove = min(self.count, prefix.count)
        return String(self.dropFirst(numberOfItemShouldRemove))
    }
    
}

extension String{

    func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)

        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }

    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat? {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

}

extension String {
    
    /// Generates a `UIImage` instance from this string using a specified
    /// attributes and size.
    ///
    /// - Parameters:
    ///     - attributes: to draw this string with. Default is `nil`.
    ///     - size: of the image to return.
    /// - Returns: a `UIImage` instance from this string using a specified
    /// attributes and size, or `nil` if the operation fails.
    func image(withAttributes attributes: [NSAttributedString.Key: Any]? = nil, size: CGSize? = nil) -> UIImage? {
        let size = size ?? (self as NSString).size(withAttributes: attributes)
        UIGraphicsBeginImageContext(size)
        (self as NSString).draw(in: CGRect(origin: .zero, size: size),
                                withAttributes: attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
