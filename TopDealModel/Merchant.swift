//
//  Merchant.swift
//
//  Created by PCPL 41 on 5/10/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Merchant: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let id = "id"
    static let image = "image"
    static let recommendationFlag = "recommendation_flag"
    static let permalink = "permalink"
    static let recommendation = "recommendation"
    static let averageRating = "average_rating"
  }

  // MARK: Properties
  public var name: String?
  public var id: Int?
  public var image: String?
  public var recommendationFlag: Bool? = false
  public var permalink: String?
  public var recommendation: Int?
  public var averageRating: String?

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
    recommendationFlag = json[SerializationKeys.recommendationFlag].boolValue
    permalink = json[SerializationKeys.permalink].string
    recommendation = json[SerializationKeys.recommendation].int
    averageRating = json[SerializationKeys.averageRating].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    dictionary[SerializationKeys.recommendationFlag] = recommendationFlag
    if let value = permalink { dictionary[SerializationKeys.permalink] = value }
    if let value = recommendation { dictionary[SerializationKeys.recommendation] = value }
    if let value = averageRating { dictionary[SerializationKeys.averageRating] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
    self.recommendationFlag = aDecoder.decodeBool(forKey: SerializationKeys.recommendationFlag)
    self.permalink = aDecoder.decodeObject(forKey: SerializationKeys.permalink) as? String
    self.recommendation = aDecoder.decodeObject(forKey: SerializationKeys.recommendation) as? Int
    self.averageRating = aDecoder.decodeObject(forKey: SerializationKeys.averageRating) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(recommendationFlag, forKey: SerializationKeys.recommendationFlag)
    aCoder.encode(permalink, forKey: SerializationKeys.permalink)
    aCoder.encode(recommendation, forKey: SerializationKeys.recommendation)
    aCoder.encode(averageRating, forKey: SerializationKeys.averageRating)
  }

}
