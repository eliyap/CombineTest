//
//  MarkdownView.swift
//  CombineTest
//
//  Created by Secret Asian Man Dev on 1/4/21.
//

import SwiftUI
import Combine

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
        uiView.editMode = editMode
    }
}


