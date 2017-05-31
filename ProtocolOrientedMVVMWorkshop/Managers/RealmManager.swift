//
//  RealmManager.swift
//  ProtocolOrientedMVVMWorkshop
//
//  Created by Michal Čičkán on 31/05/2017.
//  Copyright © 2017 RingierAxelSpringer. All rights reserved.
//

import RealmSwift
import Async

class RealmManager: NSObject {
    static var sharedInstance = RealmManager()
    
    lazy var realm : Realm = {
        let rlm = try! Realm()
        
        return rlm
    }()
    
    class func migrateRealm(version: UInt64) {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: version,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                switch oldSchemaVersion {
                case 1:
                    break
                default:
                    break
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    class func writeObject<T : Object>(_ object : T, update : Bool = false) where T: NSCopying {
        let realm = self.sharedInstance.realm
        
        Async.main() {
            do {
                let obj = object.copy() as! T
                try realm.write({
                    realm.add(obj, update: update)
                })
                
            } catch {
                //print("cannot write")
            }
        }
    }
    
    class func writeObjects<T: Object>(_ objects : [T], update : Bool = true) where T: NSCopying {
        
        for object in objects {
            writeObject(object, update : update)
        }
    }
    
    class func getObjects<T : Object>(_ predicate : NSPredicate?) -> Array<T>? where T: NSCopying {
        
        let realm = self.sharedInstance.realm
        
        // var returns segmentation fault during the building, so make it as function. It seems, that xcode with this approach
        func objects() -> Array<T>? {
            let objects : Results<T> = realm.objects(T.self)
            if let pred = predicate {
                return objects.filter(pred).convertToArray()
            }
            
            return objects.convertToArray()
        }
        
        if Thread.isMainThread {
            return objects()
        } else {
            var syncObjects: Array<T>?
            
            DispatchQueue.main.sync {
                syncObjects = objects()
            }
            
            return syncObjects
        }
    }
    
    class func getRealmObjects<T : Object>(_ predicate : NSPredicate?) -> Results<T>? where T: NSCopying {
        let realm = self.sharedInstance.realm
        
        var objects : Results<T>?
        func fillObject() {
            objects = realm.objects(T.self)
            
            if let pred = predicate {
                objects = objects?.filter(pred)
            }
        }
        
        if Thread.isMainThread {
            fillObject()
        } else {
            DispatchQueue.main.sync {
                fillObject()
            }
        }
        
        return objects
    }
    
    class func deleteObject<T: Object>(_ object : T) -> T where T: NSCopying {
        
        let realm = self.sharedInstance.realm
        Async.main() {
            do {
                let obj = object.copy() as! T
                try realm.write({
                    realm.delete(obj)
                })
            } catch {
                
            }
        }
        
        return object
    }
    
    class func deleteObject<T: Object>(_ predicate : NSPredicate ) -> T? where T: NSCopying {
        let realm = self.sharedInstance.realm
        
        let objs : Results<T> = realm.objects(T.self).filter(predicate)
        
        if objs.count > 0 {
            for obj in objs {
                do {
                    try realm.write({
                        realm.delete(obj)
                    })
                    
                    return obj
                }
                catch {
                    
                }
            }
        }
        
        return nil
    }
}

extension Results {
    func convertToArray<T : NSCopying>() -> [T] {
        var arr = Array<T>()
        
        for res in self {
            arr.append(res.copy() as! T)
        }
        
        return arr
    }
}

