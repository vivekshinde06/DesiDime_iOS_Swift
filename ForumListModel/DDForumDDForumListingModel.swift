//
//  DDForumDDForumListingModel.swift
//
//  Created by PCPL 41 on 5/11/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDForumDDForumListingModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let seoSetting = "seo_setting"
    static let unreadMessagesCounter = "unread_messages_counter"
    static let data = "data"
    static let unreadNotificationsCount = "unread_notifications_count"
    static let unreadConversationsCount = "unread_conversations_count"
  }

  // MARK: Properties
  public var seoSetting: DDForumSeoSetting?
  public var unreadMessagesCounter: Int?
  public var data: [DDForumData]?
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
    seoSetting = DDForumSeoSetting(json: json[SerializationKeys.seoSetting])
    unreadMessagesCounter = json[SerializationKeys.unreadMessagesCounter].int
    if let items = json[SerializationKeys.data].array { data = items.map { DDForumData(json: $0) } }
    unreadNotificationsCount = json[SerializationKeys.unreadNotificationsCount].int
    unreadConversationsCount = json[SerializationKeys.unreadConversationsCount].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = seoSetting { dictionary[SerializationKeys.seoSetting] = value.dictionaryRepresentation() }
    if let value = unreadMessagesCounter { dictionary[SerializationKeys.unreadMessagesCounter] = value }
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    if let value = unreadNotificationsCount { dictionary[SerializationKeys.unreadNotificationsCount] = value }
    if let value = unreadConversationsCount { dictionary[SerializationKeys.unreadConversationsCount] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.seoSetting = aDecoder.decodeObject(forKey: SerializationKeys.seoSetting) as? DDForumSeoSetting
    self.unreadMessagesCounter = aDecoder.decodeObject(forKey: SerializationKeys.unreadMessagesCounter) as? Int
    self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [DDForumData]
    self.unreadNotificationsCount = aDecoder.decodeObject(forKey: SerializationKeys.unreadNotificationsCount) as? Int
    self.unreadConversationsCount = aDecoder.decodeObject(forKey: SerializationKeys.unreadConversationsCount) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(seoSetting, forKey: SerializationKeys.seoSetting)
    aCoder.encode(unreadMessagesCounter, forKey: SerializationKeys.unreadMessagesCounter)
    aCoder.encode(data, forKey: SerializationKeys.data)
    aCoder.encode(unreadNotificationsCount, forKey: SerializationKeys.unreadNotificationsCount)
    aCoder.encode(unreadConversationsCount, forKey: SerializationKeys.unreadConversationsCount)
  }

}
