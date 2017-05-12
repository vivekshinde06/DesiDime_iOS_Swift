//
//  DDRecentPostData.swift
//
//  Created by PCPL 41 on 5/11/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDRecentPostData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let textRaw = "text_raw"
    static let forum = "forum"
    static let likeCount = "like_count"
    static let user = "user"
    static let id = "id"
    static let unapprovedPostMessage = "unapproved_post_message"
    static let text = "text"
    static let createdAt = "created_at"
    static let approved = "approved"
    static let topic = "topic"
    static let processed = "processed"
    static let postLikeStatus = "post_like_status"
  }

  // MARK: Properties
  public var textRaw: String?
  public var forum: DDRecentPostForum?
  public var likeCount: Int?
  public var user: DDRecentPostUser?
  public var id: Int?
  public var unapprovedPostMessage: String?
  public var text: String?
  public var createdAt: Int?
  public var approved: Bool? = false
  public var topic: DDRecentPostTopic?
  public var processed: Bool? = false
  public var postLikeStatus: Bool? = false

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
    textRaw = json[SerializationKeys.textRaw].string
    forum = DDRecentPostForum(json: json[SerializationKeys.forum])
    likeCount = json[SerializationKeys.likeCount].int
    user = DDRecentPostUser(json: json[SerializationKeys.user])
    id = json[SerializationKeys.id].int
    unapprovedPostMessage = json[SerializationKeys.unapprovedPostMessage].string
    text = json[SerializationKeys.text].string
    createdAt = json[SerializationKeys.createdAt].int
    approved = json[SerializationKeys.approved].boolValue
    topic = DDRecentPostTopic(json: json[SerializationKeys.topic])
    processed = json[SerializationKeys.processed].boolValue
    postLikeStatus = json[SerializationKeys.postLikeStatus].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = textRaw { dictionary[SerializationKeys.textRaw] = value }
    if let value = forum { dictionary[SerializationKeys.forum] = value.dictionaryRepresentation() }
    if let value = likeCount { dictionary[SerializationKeys.likeCount] = value }
    if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = unapprovedPostMessage { dictionary[SerializationKeys.unapprovedPostMessage] = value }
    if let value = text { dictionary[SerializationKeys.text] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    dictionary[SerializationKeys.approved] = approved
    if let value = topic { dictionary[SerializationKeys.topic] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.processed] = processed
    dictionary[SerializationKeys.postLikeStatus] = postLikeStatus
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.textRaw = aDecoder.decodeObject(forKey: SerializationKeys.textRaw) as? String
    self.forum = aDecoder.decodeObject(forKey: SerializationKeys.forum) as? DDRecentPostForum
    self.likeCount = aDecoder.decodeObject(forKey: SerializationKeys.likeCount) as? Int
    self.user = aDecoder.decodeObject(forKey: SerializationKeys.user) as? DDRecentPostUser
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.unapprovedPostMessage = aDecoder.decodeObject(forKey: SerializationKeys.unapprovedPostMessage) as? String
    self.text = aDecoder.decodeObject(forKey: SerializationKeys.text) as? String
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? Int
    self.approved = aDecoder.decodeBool(forKey: SerializationKeys.approved)
    self.topic = aDecoder.decodeObject(forKey: SerializationKeys.topic) as? DDRecentPostTopic
    self.processed = aDecoder.decodeBool(forKey: SerializationKeys.processed)
    self.postLikeStatus = aDecoder.decodeBool(forKey: SerializationKeys.postLikeStatus)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(textRaw, forKey: SerializationKeys.textRaw)
    aCoder.encode(forum, forKey: SerializationKeys.forum)
    aCoder.encode(likeCount, forKey: SerializationKeys.likeCount)
    aCoder.encode(user, forKey: SerializationKeys.user)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(unapprovedPostMessage, forKey: SerializationKeys.unapprovedPostMessage)
    aCoder.encode(text, forKey: SerializationKeys.text)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(approved, forKey: SerializationKeys.approved)
    aCoder.encode(topic, forKey: SerializationKeys.topic)
    aCoder.encode(processed, forKey: SerializationKeys.processed)
    aCoder.encode(postLikeStatus, forKey: SerializationKeys.postLikeStatus)
  }

}
