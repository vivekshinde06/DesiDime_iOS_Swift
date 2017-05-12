//
//  DDNotifications.swift
//
//  Created by PCPL 41 on 5/3/17
//  Copyright (c) Parity Cube. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDNotifications: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let createdAt = "created_at"
    static let action = "action"
    static let message = "message"
    static let actor = "actor"
    static let read = "read"
  }

  // MARK: Properties
  public var createdAt: Int?
  public var action: String?
  public var message: String?
  public var actor: DDActor?
  public var read: Bool? = false

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
    createdAt = json[SerializationKeys.createdAt].int
    action = json[SerializationKeys.action].string
    message = json[SerializationKeys.message].string
    actor = DDActor(json: json[SerializationKeys.actor])
    read = json[SerializationKeys.read].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = action { dictionary[SerializationKeys.action] = value }
    if let value = message { dictionary[SerializationKeys.message] = value }
    if let value = actor { dictionary[SerializationKeys.actor] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.read] = read
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? Int
    self.action = aDecoder.decodeObject(forKey: SerializationKeys.action) as? String
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
    self.actor = aDecoder.decodeObject(forKey: SerializationKeys.actor) as? DDActor
    self.read = aDecoder.decodeBool(forKey: SerializationKeys.read)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(action, forKey: SerializationKeys.action)
    aCoder.encode(message, forKey: SerializationKeys.message)
    aCoder.encode(actor, forKey: SerializationKeys.actor)
    aCoder.encode(read, forKey: SerializationKeys.read)
  }

}
