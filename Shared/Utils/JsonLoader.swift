//
//  JsonLoader.swift
//  TicketTest (iOS)
//
//  Created by Erik Fagerman on 2022-03-16.
//

import Foundation

public class JsonLoader {

    /** Creates a model from a json file template.
        `fileName` is the name (without the 'json' extension) and `type` is the type of object that should be decoded. */
    static func createModel<T: Decodable>(_ fileName: String, type: T.Type) -> T? {

        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {

            assertionFailure("No matching JSON file for class '\(fileName)' found in bundle.")
            return nil

        }

        do {

            let str = try String(contentsOfFile: path, encoding: String.Encoding.utf8)

            if let jsonData = str.data(using: .utf8) {

                return try JSONDecoder().decode(type, from: jsonData)

            }

        } catch { assertionFailure("Unable to decode \(fileName): Error: \(String(describing: error))") }

        return nil

    }

}
