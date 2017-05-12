//
//  Data.swift
//
//  Created by PCPL 41 on 5/10/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Data: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let state = "state"
    static let offPercent = "off_percent"
    static let user = "user"
    static let score = "score"
    static let dealUrl = "deal_url"
    static let allPostsCount = "all_posts_count"
    static let shareUrl = "share_url"
    static let fpdSuggestted = "fpd_suggestted"
    static let descriptionValue = "description"
    static let fpdFlag = "fpd_flag"
    static let commentsCount = "comments_count"
    static let voteCount = "vote_count"
    static let viewCount = "view_count"
    static let merchant = "merchant"
    static let currentPrice = "current_price"
    static let id = "id"
    static let image = "image"
    static let originalPrice = "original_price"
    static let createdAt = "created_at"
    static let title = "title"
    static let voteValue = "vote_value"
    static let frontPageSuggestionsCount = "front_page_suggestions_count"
    static let voteDownReason = "vote_down_reason"
  }

  // MARK: Properties
  public var state: String?
  public var offPercent: String?
  public var user: User?
  public var score: Int?
  public var dealUrl: String?
  public var allPostsCount: Int?
  public var shareUrl: String?
  public var fpdSuggestted: Bool? = false
  public var descriptionValue: String?
  public var fpdFlag: Bool? = false
  public var commentsCount: Int?
  public var voteCount: Int?
  public var viewCount: Int?
  public var merchant: Merchant?
  public var currentPrice: Int?
  public var id: Int?
  public var image: String?
  public var originalPrice: Int?
  public var createdAt: Int?
  public var title: String?
  public var voteValue: Int?
  public var frontPageSuggestionsCount: Int?
  public var voteDownReason: VoteDownReason?

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
    offPercent = json[SerializationKeys.offPercent].string
    user = User(json: json[SerializationKeys.user])
    score = json[SerializationKeys.score].int
    dealUrl = json[SerializationKeys.dealUrl].string
    allPostsCount = json[SerializationKeys.allPostsCount].int
    shareUrl = json[SerializationKeys.shareUrl].string
    fpdSuggestted = json[SerializationKeys.fpdSuggestted].boolValue
    descriptionValue = json[SerializationKeys.descriptionValue].string
    fpdFlag = json[SerializationKeys.fpdFlag].boolValue
    commentsCount = json[SerializationKeys.commentsCount].int
    voteCount = json[SerializationKeys.voteCount].int
    viewCount = json[SerializationKeys.viewCount].int
    merchant = Merchant(json: json[SerializationKeys.merchant])
    currentPrice = json[SerializationKeys.currentPrice].int
    id = json[SerializationKeys.id].int
    image = json[SerializationKeys.image].string
    originalPrice = json[SerializationKeys.originalPrice].int
    createdAt = json[SerializationKeys.createdAt].int
    title = json[SerializationKeys.title].string
    voteValue = json[SerializationKeys.voteValue].int
    frontPageSuggestionsCount = json[SerializationKeys.frontPageSuggestionsCount].int
    voteDownReason = VoteDownReason(json: json[SerializationKeys.voteDownReason])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[SerializationKeys.state] = value }
    if let value = offPercent { dictionary[SerializationKeys.offPercent] = value }
    if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
    if let value = score { dictionary[SerializationKeys.score] = value }
    if let value = dealUrl { dictionary[SerializationKeys.dealUrl] = value }
    if let value = allPostsCount { dictionary[SerializationKeys.allPostsCount] = value }
    if let value = shareUrl { dictionary[SerializationKeys.shareUrl] = value }
    dictionary[SerializationKeys.fpdSuggestted] = fpdSuggestted
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    dictionary[SerializationKeys.fpdFlag] = fpdFlag
    if let value = commentsCount { dictionary[SerializationKeys.commentsCount] = value }
    if let value = voteCount { dictionary[SerializationKeys.voteCount] = value }
    if let value = viewCount { dictionary[SerializationKeys.viewCount] = value }
    if let value = merchant { dictionary[SerializationKeys.merchant] = value.dictionaryRepresentation() }
    if let value = currentPrice { dictionary[SerializationKeys.currentPrice] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    if let value = originalPrice { dictionary[SerializationKeys.originalPrice] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = voteValue { dictionary[SerializationKeys.voteValue] = value }
    if let value = frontPageSuggestionsCount { dictionary[SerializationKeys.frontPageSuggestionsCount] = value }
    if let value = voteDownReason { dictionary[SerializationKeys.voteDownReason] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: SerializationKeys.state) as? String
    self.offPercent = aDecoder.decodeObject(forKey: SerializationKeys.offPercent) as? String
    self.user = aDecoder.decodeObject(forKey: SerializationKeys.user) as? User
    self.score = aDecoder.decodeObject(forKey: SerializationKeys.score) as? Int
    self.dealUrl = aDecoder.decodeObject(forKey: SerializationKeys.dealUrl) as? String
    self.allPostsCount = aDecoder.decodeObject(forKey: SerializationKeys.allPostsCount) as? Int
    self.shareUrl = aDecoder.decodeObject(forKey: SerializationKeys.shareUrl) as? String
    self.fpdSuggestted = aDecoder.decodeBool(forKey: SerializationKeys.fpdSuggestted)
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.fpdFlag = aDecoder.decodeBool(forKey: SerializationKeys.fpdFlag)
    self.commentsCount = aDecoder.decodeObject(forKey: SerializationKeys.commentsCount) as? Int
    self.voteCount = aDecoder.decodeObject(forKey: SerializationKeys.voteCount) as? Int
    self.viewCount = aDecoder.decodeObject(forKey: SerializationKeys.viewCount) as? Int
    self.merchant = aDecoder.decodeObject(forKey: SerializationKeys.merchant) as? Merchant
    self.currentPrice = aDecoder.decodeObject(forKey: SerializationKeys.currentPrice) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
    self.originalPrice = aDecoder.decodeObject(forKey: SerializationKeys.originalPrice) as? Int
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? Int
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.voteValue = aDecoder.decodeObject(forKey: SerializationKeys.voteValue) as? Int
    self.frontPageSuggestionsCount = aDecoder.decodeObject(forKey: SerializationKeys.frontPageSuggestionsCount) as? Int
    self.voteDownReason = aDecoder.decodeObject(forKey: SerializationKeys.voteDownReason) as? VoteDownReason
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: SerializationKeys.state)
    aCoder.encode(offPercent, forKey: SerializationKeys.offPercent)
    aCoder.encode(user, forKey: SerializationKeys.user)
    aCoder.encode(score, forKey: SerializationKeys.score)
    aCoder.encode(dealUrl, forKey: SerializationKeys.dealUrl)
    aCoder.encode(allPostsCount, forKey: SerializationKeys.allPostsCount)
    aCoder.encode(shareUrl, forKey: SerializationKeys.shareUrl)
    aCoder.encode(fpdSuggestted, forKey: SerializationKeys.fpdSuggestted)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(fpdFlag, forKey: SerializationKeys.fpdFlag)
    aCoder.encode(commentsCount, forKey: SerializationKeys.commentsCount)
    aCoder.encode(voteCount, forKey: SerializationKeys.voteCount)
    aCoder.encode(viewCount, forKey: SerializationKeys.viewCount)
    aCoder.encode(merchant, forKey: SerializationKeys.merchant)
    aCoder.encode(currentPrice, forKey: SerializationKeys.currentPrice)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(originalPrice, forKey: SerializationKeys.originalPrice)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(voteValue, forKey: SerializationKeys.voteValue)
    aCoder.encode(frontPageSuggestionsCount, forKey: SerializationKeys.frontPageSuggestionsCount)
    aCoder.encode(voteDownReason, forKey: SerializationKeys.voteDownReason)
  }

}
