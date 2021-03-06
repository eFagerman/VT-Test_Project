//
// ResponseOperator.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ResponseOperator: Codable, JSONEncodable, Hashable {

    public var code: String
    /** IconURL contains the URL for the operator icon */
    public var iconUrl: String?
    public var location: ResponseOperatorLocation?
    /** ProductTypes holds all the product types for the operator */
    public var productTypes: [ResponseOperatorProductType]?
    /** Resources contains a map with localizations */
    public var resources: [String: [String: String]]?

    public init(code: String, iconUrl: String? = nil, location: ResponseOperatorLocation? = nil, productTypes: [ResponseOperatorProductType]? = nil, resources: [String: [String: String]]? = nil) {
        self.code = code
        self.iconUrl = iconUrl
        self.location = location
        self.productTypes = productTypes
        self.resources = resources
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case code
        case iconUrl = "icon_url"
        case location
        case productTypes = "product_types"
        case resources
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(code, forKey: .code)
        try container.encodeIfPresent(iconUrl, forKey: .iconUrl)
        try container.encodeIfPresent(location, forKey: .location)
        try container.encodeIfPresent(productTypes, forKey: .productTypes)
        try container.encodeIfPresent(resources, forKey: .resources)
    }
}

