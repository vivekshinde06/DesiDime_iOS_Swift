//
//  DDRecentPostForum.swift
//
//  Created by PCPL 41 on 5/11/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDRecentPostForum: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let postsCount = "posts_count"
    static let topicsCount = "topics_count"
    static let descriptionValue = "description"
    static let title = "title"
    static let lastActivityAt = "last_activity_at"
    static let haveSubforum = "have_subforum"
  }

  // MARK: Properties
  public var id: Int?
  public var postsCount: Int?
  public var topicsCount: Int?
  public var descriptionValue: String?
  public var title: String?
  public var lastActivityAt: Int?
  public var haveSubforum: Bool? = false

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
    id = json[SerializationKeys.id].int
    postsCount = json[SerializationKeys.postsCount].int
    topicsCount = json[SerializationKeys.topicsCount].int
    descriptionValue = json[SerializationKeys.descriptionValue].string
    title = json[SerializationKeys.title].string
    lastActivityAt = json[SerializationKeys.lastActivityAt].int
    haveSubforum = json[SerializationKeys.haveSubforum].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = postsCount { dictionary[SerializationKeys.postsCount] = value }
    if let value = topicsCount { dictionary[SerializationKeys.topicsCount] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = lastActivityAt { dictionary[SerializationKeys.lastActivityAt] = value }
    dictionary[SerializationKeys.haveSubforum] = haveSubforum
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.postsCount = aDecoder.decodeObject(forKey: SerializationKeys.postsCount) as? Int
    self.topicsCount = aDecoder.decodeObject(forKey: SerializationKeys.topicsCount) as? Int
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.lastActivityAt = aDecoder.decodeObject(forKey: SerializationKeys.lastActivityAt) as? Int
    self.haveSubforum = aDecoder.decodeBool(forKey: SerializationKeys.haveSubforum)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(postsCount, forKey: SerializationKeys.postsCount)
    aCoder.encode(topicsCount, forKey: SerializationKeys.topicsCount)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(lastActivityAt, forKey: SerializationKeys.lastActivityAt)
    aCoder.encode(haveSubforum, forKey: SerializationKeys.haveSubforum)
  }

}
