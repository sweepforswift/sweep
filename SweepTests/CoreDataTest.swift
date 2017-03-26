//
//  CoreDataTest.swift
//  Sweep
//
//  Created by Michael Smith on 3/23/17.
//  Copyright © 2017 Michael Smith Jr. All rights reserved.
//

import XCTest
import CoreData
@testable import Sweep

class CoreDataTest: XCTestCase {
    
    func buildManagedObjectModel() -> NSManagedObjectModel{
        
        let model = NSManagedObjectModel()
        
        // Create the entity
        let entity = NSEntityDescription()
        entity.name = "User"
        entity.managedObjectClassName = String(describing: User.self)
        
        // Create the attributes
        var properties = Array<NSAttributeDescription>()
        
        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.attributeType = .stringAttributeType
        nameAttribute.isOptional = false
        nameAttribute.isIndexed = true
        properties.append(nameAttribute)
        
        let ageAttribute = NSAttributeDescription()
        ageAttribute.name = "age"
        ageAttribute.attributeType = .integer64AttributeType
        ageAttribute.isOptional = false
        ageAttribute.isIndexed = true
        properties.append(ageAttribute)
        
        // Add attributes to entity
        entity.properties = properties
        
        // Add entity to model
        model.entities = [entity]
        
        return model
    }
    
    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = self.buildManagedObjectModel()
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
    
    override func setUp() {
        super.setUp()
        CoreDataORM.managedContext = self.setUpInMemoryManagedObjectContext()
        QueryBuilder.connection = CoreDataORM.self
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyReturn() {
        let users: [User]? = User.all().get()
        XCTAssertEqual(users!, [])
    }
    
    func testCanRetreiveModel(){
        let user = userFactory(context: CoreDataORM.managedContext!)
        _ = user.save()
        
        let recUsers: [User]? = User.all().get()
        XCTAssertEqual(recUsers?.count, 1)
        XCTAssertEqual(recUsers?[0].name, user.name)
    }
    
    func testCanRetrieveModelWithFind(){
        let user = userFactory(context: CoreDataORM.managedContext!)
        _ = user.save()
        
        let user2 = userFactory(context: CoreDataORM.managedContext!)
        _ = user2.save()
        
        let recUser: User? = User.find(key: "name", value: user.name)
        XCTAssertEqual(recUser?.name, user.name)
    }
    
    func testWhereClause(){
        let user = userFactory(context: CoreDataORM.managedContext!, dict: ["age": 25])
        _ = user.save()
        
        let user2 = userFactory(context: CoreDataORM.managedContext!, dict: ["age": 35])
        _ = user2.save()
        
        let user3 = userFactory(context: CoreDataORM.managedContext!, dict: ["age": 40])
        _ = user3.save()
        
        let users: [User]? = User.all().find(where: "age", op: .greaterThan, comparedTo: 30).get()
        XCTAssertEqual(users?.count, 2)
    }
    
    func testOrWhereClause(){
        let user = userFactory(context: CoreDataORM.managedContext!, dict: ["age": 25])
        _ = user.save()
        
        let user2 = userFactory(context: CoreDataORM.managedContext!, dict: ["age": 35])
        _ = user2.save()
        
        let user3 = userFactory(context: CoreDataORM.managedContext!, dict: ["age": 40])
        _ = user3.save()
        
        let user4 = userFactory(context: CoreDataORM.managedContext!, dict: ["age": 50])
        _ = user4.save()
        
        let users: [User]? = User.all().find(where: "age", op: .lessThan, comparedTo: 30).find(orWhere: "age", op: .greaterThan, comparedTo: 37).get()
        XCTAssertEqual(users?.count, 3)
    }
    
}

@objc(User)
public class User: NSManagedObject{
    @NSManaged var name:String
    @NSManaged var age:Int
    
    public class override var model: String{
        get{
            return "User"
        }
    }
}
