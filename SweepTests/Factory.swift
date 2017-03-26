//
//  Factory.swift
//  Sweep
//
//  Created by Michael Smith on 3/25/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import Foundation
import CoreData

extension Array {
    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }
    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        indices.dropLast().forEach {
            guard case let index = Int(arc4random_uniform(UInt32(count - $0))) + $0, index != $0 else { return }
            swap(&self[$0], &self[index])
        }
        return self
    }
    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}


func userFactory(context: NSManagedObjectContext, dict: [String:Any] = [:] ) -> User {
    let names = ["Alice", "Bob", "Jane", "Jack","Michael", "Jim", "Maria", "Will"]
    let ages = [25, 30, 35, 40, 45, 50, 55, 60]
    let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
    let user = User(entity: entity!, insertInto: context)
    if dict.keys.contains("name"){
        user.name = dict["name"] as! String
    }else{
        user.name = names.shuffled.chooseOne
    }
    if dict.keys.contains("age"){
        user.age = dict["age"] as! Int
    }else{
        user.age = ages.shuffled.chooseOne
    }
    return user
}
