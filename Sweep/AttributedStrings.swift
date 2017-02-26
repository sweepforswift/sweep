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
    
    
    /**
     Changes the font type of the NSMutableAttributedString to the font matching the parameter
     
     - parameter fontName: Takes in the name of the font that is desired
     
     - returns: an NSMutableAttributedString with the font applied
     */
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
    
    /**
     Changes the font color of the NSMutableAttributedString to the color matching the parameter color. This function also has the option to select only a subset of the original NSMutableAttributedString to change the font color of.
     
     - parameter fontName: Takes in the String name of the font that is desired
     
     - parameter range: Takes in an NSRange? object that specifies the range on which the color will be applied. This will apply to the entire NSMutableAttributedString if no NSrange? is specified
     
     - returns: an NSMutableAttributedString with the font color applied
     */
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
    
    /**
     Changes the NSBackgroundColorAttributeName of the NSMutableAttributedString to the color yellow (i.e highlighting). This function has the optionional parameter called range that takes in an NSRange? to select only a subset of the original NSMutableAttributedString to highlight.
     
     - parameter range: Takes in an NSRange? object that specifies the range on which the highlighting will be applied. This will apply to the entire NSMutableAttributedString if no NSrange? is specified
     
     - returns: an NSMutableAttributedString with the highlighting applied
     */
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

    /**
     Adding a constraint of bold or italic to an NSMutableAttributedString based on the style parameter. This function also takes in an Int for size and an optional NSRange? to change a subset of the original NSMutableAttributedString.
     
     - parameter style: enum of type Style
     
     - parameter fontSize: Int that specifies the desired system size of the font
     
     - parameter range: Takes in an NSRange? object that specifies the range on which the color will be applied. This will apply to the entire NSMutableAttributedString if no NSrange? is specified
     
     - returns: an NSMutableAttributedString with the font style applied
     */
    public func addConstraints(style: Style, fontSize: Int = 17, range: NSRange? = nil)->NSMutableAttributedString{
        
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
