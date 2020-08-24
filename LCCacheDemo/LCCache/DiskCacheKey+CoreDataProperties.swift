//
//  DiskCacheKey+CoreDataProperties.swift
//  
//
//  Created by 李畅 on 2020/8/24.
//
//

import Foundation
import CoreData


extension DiskCacheKey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiskCacheKey> {
        return NSFetchRequest<DiskCacheKey>(entityName: "DiskCacheKey")
    }

    @NSManaged public var key: String?
    @NSManaged public var updateTime: Int64

}
