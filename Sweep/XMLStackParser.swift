//
//  XMLStackParser.swift
//  Sweep
//
//  Created by Michael Smith on 3/25/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

public protocol XMLable{
    /**
     Creates an instance of the object based upon the XMLNode
     - parameter node: The XML node being converted to an object
     - returns: An instance of the object
     */
    static func build(node: XMLNode) -> XMLable
    init(node: XMLNode)
}

public extension XMLable{
    /**
     Creates an instance of the object based upon the XMLNode
     - parameter node: The XML node being converted to an object
     - returns: An instance of the object
     */
    public static func build(node: XMLNode) -> XMLable{
        return self.init(node: node)
    }
}

public class XMLNode{
    var name = ""
    var content = ""
    var properties = [String:[XMLNode]]()
    var attributes = [String:String]()
    
    /**
     Converts a non-leaf node to an object by passing the XMLNode to the constructor
     - returns: An instance of the object
     */
    public func toObject<T: XMLable>() -> T?{
        return T.build(node: self) as? T
    }
    
    /**
     Decodes a leaf node into its true value instead of a string
     - returns: An instance of the leaf node cast to the proper type
     */
    public func decode<T: Decodable>() -> T?{
        return T.decode(value: self.content) as! T?
    }
    
    /**
     Converts a date string leaf node to a date based upon the provided leaf node
     - parameter toDate: The date format to the used
     - returns: An instance of the date leaf node as an object
     */
    public func decode(toDate format: String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self.content)
    }
}

extension Sequence where Iterator.Element: XMLNode{
    /**
     Converts an array of non-leaf nodes to an objects by passing the XMLNode to the constructor for each node
     - returns: An array of the objects
     */
    public func deserialize<T: XMLable>() -> [T]?{
        return self.map({ element in
            return T.build(node: element) as! T
        })
    }
}

public class XMLStackParser: NSObject, XMLParserDelegate{
    var root: XMLNode?
    var stack = [XMLNode]()
    var currentNode: XMLNode?
    
    var currentElementName: String?
    var currentElementData = ""
    
    /**
     Creates an XMLParser to parse an XML string
     - parameter with: The XML string to parse
     - returns: The root xml node
     */
    func parse(with string: String) -> XMLNode?{
        return self.parse(with: string.data(using: .utf8)!)
    }
    
    /**
     Creates an XMLParser to parse XML data
     - parameter with: The XML data to parse
     - returns: The root xml node
     */
    func parse(with data: Data) -> XMLNode?{
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
        
        return root
    }
    
    public func parserDidStartDocument(_ parser: XMLParser) {
        root = nil
        stack = [XMLNode]()
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        let node = XMLNode()
        node.name = elementName
        node.attributes = attributeDict
        stack.append(node)
        
        if let currentNode = currentNode{
            if currentNode.properties[elementName] != nil{
                currentNode.properties[elementName]?.append(node)
            } else {
                currentNode.properties[elementName] = [node]
            }
        }
        
        currentNode = node
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if let poppedNode = stack.popLast(){
            poppedNode.content = poppedNode.content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if (stack.isEmpty){
                root = poppedNode
                currentNode = nil
            }else{
                currentNode = stack.last
            }
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentNode?.content += string
    }
    
    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        let cdata = String(data: CDATABlock, encoding: .utf8)
        if let cdata = cdata{
            currentNode?.content += cdata
        }
    }
    
    
}
