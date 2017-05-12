//
//  DDRecentPostUser.swift
//
//  Created by PCPL 41 on 5/11/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDRecentPostUser: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let id = "id"
    static let image = "image"
    static let karma = "karma"
    static let currentDimes = "current_dimes"
    static let rank = "rank"
    static let fpdCount = "fpd_count"
  }

  // MARK: Properties
  public var name: String?
  public var id: Int?
  public var image: String?
  public var karma: Int?
  public var currentDimes: Int?
  public var rank: String?
  public var fpdCount: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    name = json[SerializationKeys.name].string
    id = json[SerializationKeys.id].int
    image = json[SerializationKeys.image].string
    karma = json[SerializationKeys.karma].int
    currentDimes = json[SerializationKeys.currentDimes].int
    rank = json[SerializationKeys.rank].string
    fpdCount = json[SerializationKeys.fpdCount].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    if let value = karma { dictionary[SerializationKeys.karma] = value }
    if let value = currentDimes { dictionary[SerializationKeys.currentDimes] = value }
    if let value = rank { dictionary[SerializationKeys.rank] = value }
    if let value = fpdCount { dictionary[SerializationKeys.fpdCount] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
    self.karma = aDecoder.decodeObject(forKey: SerializationKeys.karma) as? Int
    self.currentDimes = aDecoder.decodeObject(forKey: SerializationKeys.currentDimes) as? Int
    self.rank = aDecoder.decodeObject(forKey: SerializationKeys.rank) as? String
    self.fpdCount = aDecoder.decodeObject(forKey: SerializationKeys.fpdCount) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(karma, forKey: SerializationKeys.karma)
    aCoder.encode(currentDimes, forKey: SerializationKeys.currentDimes)
    aCoder.encode(rank, forKey: SerializationKeys.rank)
    aCoder.encode(fpdCount, forKey: SerializationKeys.fpdCount)
  }

}
