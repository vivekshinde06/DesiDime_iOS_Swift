//
//  DDForumSeoSetting.swift
//
//  Created by PCPL 41 on 5/11/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDForumSeoSetting: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let descriptionValue = "description"
    static let title = "title"
    static let keywords = "keywords"
    static let webUrl = "web_url"
  }

  // MARK: Properties
  public var descriptionValue: String?
  public var title: String?
  public var keywords: String?
  public var webUrl: String?

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
    title = json[SerializationKeys.title].string
    keywords = json[SerializationKeys.keywords].string
    webUrl = json[SerializationKeys.webUrl].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = keywords { dictionary[SerializationKeys.keywords] = value }
    if let value = webUrl { dictionary[SerializationKeys.webUrl] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.keywords = aDecoder.decodeObject(forKey: SerializationKeys.keywords) as? String
    self.webUrl = aDecoder.decodeObject(forKey: SerializationKeys.webUrl) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(keywords, forKey: SerializationKeys.keywords)
    aCoder.encode(webUrl, forKey: SerializationKeys.webUrl)
  }

}
