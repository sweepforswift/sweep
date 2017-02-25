//
//  AttributedStrings.swift
//  Sweep
//
//  Created by Will Mock on 2/24/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//
import Foundation

public enum Style{
    case bold
    case italic
}

public extension NSMutableAttributedString {
    
    public func changeFontType(fontName: String)->NSMutableAttributedString{
        
        let fonts: [String] = UIFont.familyNames
        
        let myAttribute = [ NSFontAttributeName: UIFont.fontNames(forFamilyName: fontName) ]
        
        if fonts.contains(fontName) {
            print("success")
            self.addAttribute(self.string, value: myAttribute, range: NSMakeRange(0, self.length))
        }else{
            print("failed to change font")
        }
        
        return self
    }
    
    public func changeFontColor(color: UIColor, range: NSRange? = nil)->NSMutableAttributedString{
        
        
        let attributedString = NSMutableAttributedString(string: self.string)
        var trueRange: NSRange
        if let range = range{
            trueRange = range
        }else{
            trueRange = (self.string as NSString).range(of: self.string)
        }
        
        attributedString.addAttribute(NSForegroundColorAttributeName, value: color , range: trueRange)
        
        return attributedString
    }
    
    
    public func highlight(range: NSRange? = nil)->NSMutableAttributedString{
        
        let attributedString = NSMutableAttributedString(string: self.string)
        
        var trueRange: NSRange
        if let range = range{
            trueRange = range
        }else{
            trueRange = (self.string as NSString).range(of: self.string)
        }
        
        attributedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellow , range: trueRange)
        
        return attributedString
    }

    public func addConstraints(style: Style, fontSize: Int, range: NSRange? = nil)->NSMutableAttributedString{
        
        var trueRange: NSRange
        if let range = range{
            trueRange = range
        }else{
            trueRange = NSMakeRange(0, self.length)
        }
        
    
        switch style {
        case .bold:
            let myAttribute = [ NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(fontSize)) ]
            self.addAttribute(self.string, value: myAttribute, range: trueRange)
        case .italic:
            let myAttribute = [ NSFontAttributeName: UIFont.italicSystemFont(ofSize: CGFloat(fontSize)) ]
            self.addAttribute(self.string, value: myAttribute, range: trueRange)
        }
        
        return self
    }
    
}
