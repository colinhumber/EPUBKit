//
//  EPUBDocument.swift
//  EPUBKit
//
//  Created by Witek on 09/06/2017.
//  Copyright © 2017 Witek Bobrowski. All rights reserved.
//

import Foundation

public struct EPUBDocument {

    public let directory: URL
    public let contentDirectory: URL
    public let metadata: EPUBMetadata
    public let manifest: EPUBManifest
    public let spine: EPUBSpine
    public let tableOfContents: EPUBTableOfContents?
    public let isEncrypted: Bool

    init (directory: URL,
          contentDirectory: URL,
          metadata: EPUBMetadata,
          manifest: EPUBManifest,
          spine: EPUBSpine,
          tableOfContents: EPUBTableOfContents?,
          isEncrypted: Bool = false) {
        self.directory = directory
        self.contentDirectory = contentDirectory
        self.metadata = metadata
        self.manifest = manifest
        self.spine = spine
        self.tableOfContents = tableOfContents
        self.isEncrypted = isEncrypted
    }

    public init?(url: URL) {
        guard let document = try? EPUBParser().parse(documentAt: url) else { return nil }
        self = document
    }

}

extension EPUBDocument {
    public var title: String? { metadata.title }
    public var author: String? { metadata.creator?.name }
    public var publisher: String? { metadata.publisher }
    public var cover: URL? {
        guard let coverId = metadata.coverId, let path = manifest.items[coverId]?.path else {
            return nil
        }
        return contentDirectory.appendingPathComponent(path)
    }
}
