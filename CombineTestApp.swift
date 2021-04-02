//
//  CombineTestApp.swift
//  CombineTest
//
//  Created by Secret Asian Man Dev on 1/4/21.
//

import SwiftUI

@main
struct CombineTestApp: App {
    
    @StateObject var document = MarkdownFile()
    
    var body: some Scene {
        FileScene
    }
    
    /// Option 1: WindowGroup
    var WindowScene: some Scene {
        WindowGroup {
            WindowView(document: document)
        }
    }
    
    /// Option 2: File Based:
    var FileScene: some Scene {
        DocumentGroup(newDocument: MarkdownFile()) { file in
            FileView(document: file.$document)
        }
    }
    
    var WrapperScene: some Scene {
        DocumentGroup(newDocument: MarkdownFile()) { file in
            Wrapper(document: file.$document)
        }
    }
}

struct Wrapper: View {
    
    @Binding var document: MarkdownFile
    
    var body: some View {
        WindowView(document: document)
    }
}
