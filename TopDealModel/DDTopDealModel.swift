//
//  DDTopDealModel.swift
//
//  Created by PCPL 41 on 5/10/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDTopDealModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let deals = "deals"
    static let seoSetting = "seo_setting"
    static let unreadMessagesCounter = "unread_messages_counter"
    static let unreadNotificationsCount = "unread_notifications_count"
    static let unreadConversationsCount = "unread_conversations_count"
  }

  // MARK: Properties
  public var deals: Deals?
  public var seoSetting: SeoSetting?
  public var unreadMessagesCounter: Int?
  public var unreadNotificationsCount: Int?
  public var unreadConversationsCount: Int?

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
    deals = Deals(json: json[SerializationKeys.deals])
    seoSetting = SeoSetting(json: json[SerializationKeys.seoSetting])
    unreadMessagesCounter = json[SerializationKeys.unreadMessagesCounter].int
    unreadNotificationsCount = json[SerializationKeys.unreadNotificationsCount].int
    unreadConversationsCount = json[SerializationKeys.unreadConversationsCount].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = deals { dictionary[SerializationKeys.deals] = value.dictionaryRepresentation() }
    if let value = seoSetting { dictionary[SerializationKeys.seoSetting] = value.dictionaryRepresentation() }
    if let value = unreadMessagesCounter { dictionary[SerializationKeys.unreadMessagesCounter] = value }
    if let value = unreadNotificationsCount { dictionary[SerializationKeys.unreadNotificationsCount] = value }
    if let value = unreadConversationsCount { dictionary[SerializationKeys.unreadConversationsCount] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.deals = aDecoder.decodeObject(forKey: SerializationKeys.deals) as? Deals
    self.seoSetting = aDecoder.decodeObject(forKey: SerializationKeys.seoSetting) as? SeoSetting
    self.unreadMessagesCounter = aDecoder.decodeObject(forKey: SerializationKeys.unreadMessagesCounter) as? Int
    self.unreadNotificationsCount = aDecoder.decodeObject(forKey: SerializationKeys.unreadNotificationsCount) as? Int
    self.unreadConversationsCount = aDecoder.decodeObject(forKey: SerializationKeys.unreadConversationsCount) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(deals, forKey: SerializationKeys.deals)
    aCoder.encode(seoSetting, forKey: SerializationKeys.seoSetting)
    aCoder.encode(unreadMessagesCounter, forKey: SerializationKeys.unreadMessagesCounter)
    aCoder.encode(unreadNotificationsCount, forKey: SerializationKeys.unreadNotificationsCount)
    aCoder.encode(unreadConversationsCount, forKey: SerializationKeys.unreadConversationsCount)
  }

}
