//
//  DDActor.swift
//
//  Created by PCPL 41 on 5/3/17
//  Copyright (c) Parity Cube. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDActor: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let id = "id"
    static let followValue = "follow_value"
    static let image = "image"
  }

  // MARK: Properties
  public var name: String?
  public var id: Int?
  public var followValue: Int?
  public var image: String?

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
    followValue = json[SerializationKeys.followValue].int
    image = json[SerializationKeys.image].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = followValue { dictionary[SerializationKeys.followValue] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.followValue = aDecoder.decodeObject(forKey: SerializationKeys.followValue) as? Int
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(followValue, forKey: SerializationKeys.followValue)
    aCoder.encode(image, forKey: SerializationKeys.image)
  }

}
