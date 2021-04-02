//
//  ContentView.swift
//  CombineTest
//
//  Created by Secret Asian Man Dev on 1/4/21.
//

import SwiftUI
import Combine

struct WindowView: View {
    
    @ObservedObject var document: MarkdownFile
    @AppStorage("editMode") var editMode: EditMode = EditMode.typing
    
    var body: some View {
        Picker(selection: $editMode, label: Text("Allow Publication"), content: {
            Text("marking").tag(EditMode.marking)
            Text("typing").tag(EditMode.typing)
        })
        TextField("Text...", text: $document.text)
        MarkdownView(editMode: editMode, textPub: nonTypingTextChange, text: $document.text)
    }
    
    var nonTypingTextChange: AnyPublisher<String, Never> {
        document.$text
            .filter { _ in editMode != .typing }
            .map {
//                print("did pass not typing filter")
                return $0
            }
            .eraseToAnyPublisher()
    }
}

struct FileView: View {
    
    @Binding var document: MarkdownFile
    @AppStorage("editMode") var editMode: EditMode = EditMode.typing
    
    var body: some View {
        Picker(selection: $editMode, label: Text("Allow Publication"), content: {
            Text("marking").tag(EditMode.marking)
            Text("typing").tag(EditMode.typing)
        })
        TextField("Text...", text: $document.text)
        MarkdownView(editMode: editMode, textPub: nonTypingTextChange, text: $document.text)
    }
    
    var nonTypingTextChange: AnyPublisher<String, Never> {
        document.$text
            .filter { _ in editMode != .typing }
            .map {
//                print("did pass not typing filter")
                return $0
            }
            .eraseToAnyPublisher()
    }
}

