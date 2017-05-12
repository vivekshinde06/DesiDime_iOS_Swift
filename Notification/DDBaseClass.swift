//
//  DDBaseClass.swift
//
//  Created by PCPL 41 on 5/3/17
//  Copyright (c) Parity Cube. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DDBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let notificationModel = "NotificationModel"
  }

  // MARK: Properties
  public var notificationModel: DDNotificationModel?

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
    notificationModel = DDNotificationModel(json: json[SerializationKeys.notificationModel])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = notificationModel { dictionary[SerializationKeys.notificationModel] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.notificationModel = aDecoder.decodeObject(forKey: SerializationKeys.notificationModel) as? DDNotificationModel
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(notificationModel, forKey: SerializationKeys.notificationModel)
  }

}
