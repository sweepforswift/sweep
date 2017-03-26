//
//  XMLStackParser.swift
//  Sweep
//
//  Created by Michael Smith on 3/25/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation

public protocol XMLable{
    static func build(node: XMLNode) -> Self
    init(node: XMLNode)
}

public class XMLNode: XMLable{
    var name = ""
    var content = ""
    var properties = [String:[XMLable]]()
    var attributes = [String:String]()
    
    public static func build(node: XMLNode) -> Self{
       return self.init(node: node)
    }
    
    required public init(node: XMLNode){
        
    }
    
    init(){
        
    }
}

public class XMLStackParser: NSObject, XMLParserDelegate{
    var root: XMLNode?
    var stack = [XMLNode]()
    var currentNode: XMLNode?
    private var types: [String: XMLable.Type]
    
    var currentElementName: String?
    var currentElementData = ""
    
    init(types: [String: XMLable.Type]){
        self.types = types
    }
    
    override init(){
        self.types = [:]
        super.init()
    }
    
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
