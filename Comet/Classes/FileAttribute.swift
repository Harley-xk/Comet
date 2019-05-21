//
//  FileAttribute.swift
//  Comet
//
//  Created by Harley-xk on 2019/5/21.
//

import Foundation

public struct FileAttribute {
    
    public internal(set) var size: Int64
    
    public internal(set) var fileType: FileAttributeType

    public internal(set) var creationDate: Date?
    public internal(set) var modificationDate: Date?

    public internal(set) var ownerAccountID: Int?
    public internal(set) var ownerAccountName: String?

    public internal(set) var groupOwnerAccountID: Int?
    public internal(set) var groupOwnerAccountName: String?

    public internal(set) var immutable: Bool
    public internal(set) var appendOnly: Bool

    public internal(set) var extensionHidden: Bool

    public internal(set) var systemNumber: Int
    public internal(set) var referenceCount: Int
    public internal(set) var posixPermissions: Int
    public internal(set) var systemFileNumber: Int
    public internal(set) var hfsCreatorCode: OSType
    public internal(set) var hfsTypeCode: OSType
    
    init(attributes: [FileAttributeKey : Any]) {
        systemNumber = attributes[.systemNumber] as? Int ?? 0
        referenceCount = attributes[.referenceCount] as? Int ?? 0
        groupOwnerAccountID = attributes[.groupOwnerAccountID] as? Int
        groupOwnerAccountName = attributes[.groupOwnerAccountName] as? String
        ownerAccountID = attributes[.ownerAccountID] as? Int
        ownerAccountName = attributes[.ownerAccountName] as? String
        creationDate = attributes[.creationDate] as? Date
        modificationDate = attributes[.modificationDate] as? Date
        fileType = FileAttributeType(rawValue: attributes[.type] as? String ?? "")
        size = attributes [.size] as? Int64 ?? 0
        posixPermissions = attributes[.posixPermissions] as? Int ?? 0
        systemFileNumber = attributes[.systemFileNumber] as? Int ?? 0
        extensionHidden = attributes[.extensionHidden] as? Bool ?? false
        hfsCreatorCode = attributes[.hfsCreatorCode] as? OSType ?? 0
        hfsTypeCode = attributes[.hfsTypeCode] as? OSType ?? 0
        immutable = attributes[.immutable] as? Bool ?? false
        appendOnly = attributes[.appendOnly] as? Bool ?? false
    }
}
