//
//  ContentView.swift
//  CombineTest
//
//  Created by Secret Asian Man Dev on 1/4/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var textObject = MarkdownFile()
    @AppStorage("editMode") var editMode: EditMode = EditMode.typing
    
    var body: some View {
        Picker(selection: $editMode, label: Text("Allow Publication"), content: {
            Text("marking").tag(EditMode.marking)
            Text("typing").tag(EditMode.typing)
        })
        TextField("Text...", text: $textObject.text)
        MarkdownView(editMode: editMode, textPub: nonTypingTextChange, text: $textObject.text)
    }
    
    var nonTypingTextChange: AnyPublisher<String, Never> {
        textObject.$text
            .filter { _ in editMode != .typing }
            .map {
//                print("did pass not typing filter")
                return $0
            }
            .eraseToAnyPublisher()
    }
}

