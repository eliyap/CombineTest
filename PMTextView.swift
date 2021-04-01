//
//  PMTextView.swift
//  CombineTest
//
//  Created by Secret Asian Man Dev on 1/4/21.
//

import Combine
import UIKit

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
