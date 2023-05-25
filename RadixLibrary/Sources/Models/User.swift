import Foundation

public struct User: Codable, Equatable {
  public let firstName: String
  public let lastName: String
  public let phoneNumber: String

  public init(firstName: String, lastName: String, phoneNumber: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.phoneNumber = phoneNumber
  }
}
