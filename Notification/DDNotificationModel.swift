//
//  DDNotificationModel.swift
//
//  Created by PCPL 41 on 5/3/17
//  Copyright (c) Parity Cube. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDNotificationModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let unreadConversationsCount = "unread_conversations_count"
    static let notifications = "notifications"
    static let unreadNotificationsCount = "unread_notifications_count"
    static let unreadMessagesCounter = "unread_messages_counter"
  }

  // MARK: Properties
  public var unreadConversationsCount: Int?
  public var notifications: [DDNotifications]?
  public var unreadNotificationsCount: Int?
  public var unreadMessagesCounter: Int?

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
    unreadConversationsCount = json[SerializationKeys.unreadConversationsCount].int
    if let items = json[SerializationKeys.notifications].array { notifications = items.map { DDNotifications(json: $0) } }
    unreadNotificationsCount = json[SerializationKeys.unreadNotificationsCount].int
    unreadMessagesCounter = json[SerializationKeys.unreadMessagesCounter].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = unreadConversationsCount { dictionary[SerializationKeys.unreadConversationsCount] = value }
    if let value = notifications { dictionary[SerializationKeys.notifications] = value.map { $0.dictionaryRepresentation() } }
    if let value = unreadNotificationsCount { dictionary[SerializationKeys.unreadNotificationsCount] = value }
    if let value = unreadMessagesCounter { dictionary[SerializationKeys.unreadMessagesCounter] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.unreadConversationsCount = aDecoder.decodeObject(forKey: SerializationKeys.unreadConversationsCount) as? Int
    self.notifications = aDecoder.decodeObject(forKey: SerializationKeys.notifications) as? [DDNotifications]
    self.unreadNotificationsCount = aDecoder.decodeObject(forKey: SerializationKeys.unreadNotificationsCount) as? Int
    self.unreadMessagesCounter = aDecoder.decodeObject(forKey: SerializationKeys.unreadMessagesCounter) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(unreadConversationsCount, forKey: SerializationKeys.unreadConversationsCount)
    aCoder.encode(notifications, forKey: SerializationKeys.notifications)
    aCoder.encode(unreadNotificationsCount, forKey: SerializationKeys.unreadNotificationsCount)
    aCoder.encode(unreadMessagesCounter, forKey: SerializationKeys.unreadMessagesCounter)
  }

}
