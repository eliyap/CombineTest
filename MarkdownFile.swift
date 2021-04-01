//
//  MarkdownFile.swift
//  CombineTest
//
//  Created by Secret Asian Man Dev on 1/4/21.
//

import SwiftUI
import UniformTypeIdentifiers

final class MarkdownFile: FileDocument, ObservableObject {
    /// tell the system we support only plain text
    static var readableContentTypes = [UTType.plainText]

    @Published var text: String

    /// a simple initializer that creates new, empty documents
    init(text: String = "") {
        self.text = text
    }

    /// Loads data that has been saved previously.
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    /// Called when the system wants to write data to disk.
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}

