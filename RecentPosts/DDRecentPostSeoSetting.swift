//
//  DDRecentPostSeoSetting.swift
//
//  Created by PCPL 41 on 5/11/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDRecentPostSeoSetting: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let descriptionValue = "description"
    static let webUrl = "web_url"
    static let title = "title"
  }

  // MARK: Properties
  public var descriptionValue: String?
  public var webUrl: String?
  public var title: String?

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
    descriptionValue = json[SerializationKeys.descriptionValue].string
    webUrl = json[SerializationKeys.webUrl].string
    title = json[SerializationKeys.title].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = webUrl { dictionary[SerializationKeys.webUrl] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.webUrl = aDecoder.decodeObject(forKey: SerializationKeys.webUrl) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(webUrl, forKey: SerializationKeys.webUrl)
    aCoder.encode(title, forKey: SerializationKeys.title)
  }

}
