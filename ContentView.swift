//
//  ContentView.swift
//  CombineTest
//
//  Created by Secret Asian Man Dev on 1/4/21.
//

import SwiftUI
import Combine

final internal class TextObject: ObservableObject {
    @Published var text: String = ""
}

struct ContentView: View {
    
    @StateObject var textObject = TextObject()
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

struct MarkdownView: UIViewRepresentable {
    
    typealias UIViewType = PMTextView
    
    private let textView = UIViewType()
    
    public var editMode: EditMode
    
    public let textPub: AnyPublisher<String, Never>
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UIViewType {
        /// load provided document markdown
        textView.text = text
        
        /// respond to user changes in Font Size
        /// source: https://stackoverflow.com/a/57449881/12395667
        textView.adjustsFontForContentSizeCategory = true
        
        textView.setup(
            text: textPub
        )
        
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
        
    }
}

final internal class PMTextView: UITextView {
    
    var textCancellable: AnyCancellable? = .none
    
    /// attach publisher to local commands
    func setup(text: AnyPublisher<String, Never>) -> Void {
        textCancellable = text
            .sink(receiveValue: registerUndo)
    }
    
    private func registerUndo(_ text: String) -> Void {
        
        print("did register undo")
        
        guard let um = undoManager else {
            return
        }
        
        um.registerUndo(withTarget: self) {
            $0.text = text
        }
    }
    
    override var keyCommands: [UIKeyCommand]? {
        let cmds = super.keyCommands ?? []
        return cmds
    }
}
