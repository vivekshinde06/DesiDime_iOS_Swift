//
//  DDRecentPostDDRecentPostModel.swift
//
//  Created by PCPL 41 on 5/11/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDRecentPostDDRecentPostModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let seoSetting = "seo_setting"
    static let totalCount = "total_count"
    static let data = "data"
  }

  // MARK: Properties
  public var seoSetting: DDRecentPostSeoSetting?
  public var totalCount: Int?
  public var data: [DDRecentPostData]?

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
    seoSetting = DDRecentPostSeoSetting(json: json[SerializationKeys.seoSetting])
    totalCount = json[SerializationKeys.totalCount].int
    if let items = json[SerializationKeys.data].array { data = items.map { DDRecentPostData(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = seoSetting { dictionary[SerializationKeys.seoSetting] = value.dictionaryRepresentation() }
    if let value = totalCount { dictionary[SerializationKeys.totalCount] = value }
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.seoSetting = aDecoder.decodeObject(forKey: SerializationKeys.seoSetting) as? DDRecentPostSeoSetting
    self.totalCount = aDecoder.decodeObject(forKey: SerializationKeys.totalCount) as? Int
    self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [DDRecentPostData]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(seoSetting, forKey: SerializationKeys.seoSetting)
    aCoder.encode(totalCount, forKey: SerializationKeys.totalCount)
    aCoder.encode(data, forKey: SerializationKeys.data)
  }

}
