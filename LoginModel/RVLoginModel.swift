//
//  RVLoginModel.swift
//
//  Created by Ankit S on 4/17/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class RVLoginModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let createdAt = "created_at"
    static let refreshToken = "refresh_token"
    static let tokenType = "token_type"
    static let accessToken = "access_token"
    static let expiresIn = "expires_in"
  }

  // MARK: Properties
  public var createdAt: String?
  public var refreshToken: String?
  public var tokenType: String?
  public var accessToken: String?
  public var expiresIn: String?

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
    createdAt = json[SerializationKeys.createdAt].string
    refreshToken = json[SerializationKeys.refreshToken].string
    tokenType = json[SerializationKeys.tokenType].string
    accessToken = json[SerializationKeys.accessToken].string
    expiresIn = json[SerializationKeys.expiresIn].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = refreshToken { dictionary[SerializationKeys.refreshToken] = value }
    if let value = tokenType { dictionary[SerializationKeys.tokenType] = value }
    if let value = accessToken { dictionary[SerializationKeys.accessToken] = value }
    if let value = expiresIn { dictionary[SerializationKeys.expiresIn] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.refreshToken = aDecoder.decodeObject(forKey: SerializationKeys.refreshToken) as? String
    self.tokenType = aDecoder.decodeObject(forKey: SerializationKeys.tokenType) as? String
    self.accessToken = aDecoder.decodeObject(forKey: SerializationKeys.accessToken) as? String
    self.expiresIn = aDecoder.decodeObject(forKey: SerializationKeys.expiresIn) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(refreshToken, forKey: SerializationKeys.refreshToken)
    aCoder.encode(tokenType, forKey: SerializationKeys.tokenType)
    aCoder.encode(accessToken, forKey: SerializationKeys.accessToken)
    aCoder.encode(expiresIn, forKey: SerializationKeys.expiresIn)
  }

}
