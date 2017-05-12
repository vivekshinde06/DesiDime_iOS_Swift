//
//  DDRecentPostTopic.swift
//
//  Created by PCPL 41 on 5/11/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDRecentPostTopic: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let state = "state"
    static let updatedAt = "updated_at"
    static let actulPostsCount = "actul_posts_count"
    static let shareUrl = "share_url"
    static let score = "score"
    static let forumName = "forum_name"
    static let fpdFlag = "fpd_flag"
    static let voteCount = "vote_count"
    static let viewCount = "view_count"
    static let id = "id"
    static let postsCount = "posts_count"
    static let lastActivityAt = "last_activity_at"
    static let frontPageSuggestionsCount = "front_page_suggestions_count"
    static let title = "title"
  }

  // MARK: Properties
  public var state: String?
  public var updatedAt: String?
  public var actulPostsCount: Int?
  public var shareUrl: String?
  public var score: Int?
  public var forumName: String?
  public var fpdFlag: Bool? = false
  public var voteCount: Int?
  public var viewCount: Int?
  public var id: Int?
  public var postsCount: Int?
  public var lastActivityAt: Int?
  public var frontPageSuggestionsCount: Int?
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
    state = json[SerializationKeys.state].string
    updatedAt = json[SerializationKeys.updatedAt].string
    actulPostsCount = json[SerializationKeys.actulPostsCount].int
    shareUrl = json[SerializationKeys.shareUrl].string
    score = json[SerializationKeys.score].int
    forumName = json[SerializationKeys.forumName].string
    fpdFlag = json[SerializationKeys.fpdFlag].boolValue
    voteCount = json[SerializationKeys.voteCount].int
    viewCount = json[SerializationKeys.viewCount].int
    id = json[SerializationKeys.id].int
    postsCount = json[SerializationKeys.postsCount].int
    lastActivityAt = json[SerializationKeys.lastActivityAt].int
    frontPageSuggestionsCount = json[SerializationKeys.frontPageSuggestionsCount].int
    title = json[SerializationKeys.title].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[SerializationKeys.state] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = actulPostsCount { dictionary[SerializationKeys.actulPostsCount] = value }
    if let value = shareUrl { dictionary[SerializationKeys.shareUrl] = value }
    if let value = score { dictionary[SerializationKeys.score] = value }
    if let value = forumName { dictionary[SerializationKeys.forumName] = value }
    dictionary[SerializationKeys.fpdFlag] = fpdFlag
    if let value = voteCount { dictionary[SerializationKeys.voteCount] = value }
    if let value = viewCount { dictionary[SerializationKeys.viewCount] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = postsCount { dictionary[SerializationKeys.postsCount] = value }
    if let value = lastActivityAt { dictionary[SerializationKeys.lastActivityAt] = value }
    if let value = frontPageSuggestionsCount { dictionary[SerializationKeys.frontPageSuggestionsCount] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: SerializationKeys.state) as? String
    self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    self.actulPostsCount = aDecoder.decodeObject(forKey: SerializationKeys.actulPostsCount) as? Int
    self.shareUrl = aDecoder.decodeObject(forKey: SerializationKeys.shareUrl) as? String
    self.score = aDecoder.decodeObject(forKey: SerializationKeys.score) as? Int
    self.forumName = aDecoder.decodeObject(forKey: SerializationKeys.forumName) as? String
    self.fpdFlag = aDecoder.decodeBool(forKey: SerializationKeys.fpdFlag)
    self.voteCount = aDecoder.decodeObject(forKey: SerializationKeys.voteCount) as? Int
    self.viewCount = aDecoder.decodeObject(forKey: SerializationKeys.viewCount) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.postsCount = aDecoder.decodeObject(forKey: SerializationKeys.postsCount) as? Int
    self.lastActivityAt = aDecoder.decodeObject(forKey: SerializationKeys.lastActivityAt) as? Int
    self.frontPageSuggestionsCount = aDecoder.decodeObject(forKey: SerializationKeys.frontPageSuggestionsCount) as? Int
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: SerializationKeys.state)
    aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    aCoder.encode(actulPostsCount, forKey: SerializationKeys.actulPostsCount)
    aCoder.encode(shareUrl, forKey: SerializationKeys.shareUrl)
    aCoder.encode(score, forKey: SerializationKeys.score)
    aCoder.encode(forumName, forKey: SerializationKeys.forumName)
    aCoder.encode(fpdFlag, forKey: SerializationKeys.fpdFlag)
    aCoder.encode(voteCount, forKey: SerializationKeys.voteCount)
    aCoder.encode(viewCount, forKey: SerializationKeys.viewCount)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(postsCount, forKey: SerializationKeys.postsCount)
    aCoder.encode(lastActivityAt, forKey: SerializationKeys.lastActivityAt)
    aCoder.encode(frontPageSuggestionsCount, forKey: SerializationKeys.frontPageSuggestionsCount)
    aCoder.encode(title, forKey: SerializationKeys.title)
  }

}
