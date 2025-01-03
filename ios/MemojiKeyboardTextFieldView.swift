import Foundation
import SwiftUI
import UIKit

class MemojiKeyboardTextField: UITextView {
  override var textInputContextIdentifier: String? { "" }
  
  override var textInputMode: UITextInputMode? {
    for mode in UITextInputMode.activeInputModes {
      if mode.primaryLanguage == "emoji" {
        return mode
      }
    }
    return nil
  }
}

@available(iOS 13.0, *)
extension MemojiKeyboardTextFieldView {
  class Coordinator: NSObject, UITextViewDelegate {
    @Binding private var onChosen: (([String: Any]) -> Void)
    
    init(onChosen: Binding<(([String: Any]) -> Void)>) {
      self._onChosen = onChosen
    }
    
    func textViewDidChange(_ textView: UITextView) {
      guard let attributedString = textView.attributedText else { return }
      let fullRange = NSRange(location: 0, length: attributedString.length)
      
      if #available(iOS 18.0, *) {
        attributedString.enumerateAttribute(.adaptiveImageGlyph, in: fullRange, options: []) { (value, range, stop) in
          if let adaptiveImageGlyph = value as? NSAdaptiveImageGlyph {
            let glyphAttributedString = attributedString.attributedSubstring(from: range)
            
            let originalImage = adaptiveImageGlyph.image
            
            let desiredSize = CGSize(width: 200, height: 200)
            
            let scale = UIScreen.main.scale
            
            var baselineOffset = CGPoint.zero
            var capHeight = CGSize.zero
            
            if let cgImage = adaptiveImageGlyph.image(
              forProposedSize: desiredSize,
              scaleFactor: scale,
              imageOffset: &baselineOffset,
              imageSize: &capHeight
            ) {
              let originalImage = UIImage(cgImage: cgImage, scale: scale, orientation: .up)
              
              if let imageData = originalImage.pngData() {
                let base64String = imageData.base64EncodedString()
                onChosen(["data": base64String])
              }                        }
          }
        }
      } else {
        attributedString.enumerateAttributes(in: NSMakeRange(0, textView.attributedText.length), options: []) { (attachment, range, _) in
          attachment.values.forEach({ (value) in
            if ((value as? NSTextAttachment) != nil) {
              let textAttachment: NSTextAttachment = value as! NSTextAttachment
              textView.isEditable = false
              
              if let imageData = textAttachment.image?.pngData() {
                let base64String = imageData.base64EncodedString()
                
                onChosen((["data": base64String]))
              }
              return
            }
          })
        }
      }
    }
  }
}

@available(iOS 13.0, *)
struct MemojiKeyboardTextFieldView: UIViewRepresentable {
  @Binding private var onChosen: (([String: Any]) -> Void)
  
  private var textView = MemojiKeyboardTextField()
  
  init(onChosen: Binding<(([String: Any]) -> Void)>) {
    textView.allowsEditingTextAttributes = true
    textView.clearsOnInsertion = true
    
    self._onChosen = onChosen
  }
  
  func makeUIView(context: Context) -> MemojiKeyboardTextField {
    textView.delegate = context.coordinator
    textView.overrideUserInterfaceStyle = .dark
    
    return textView
  }
  
  func updateUIView(_ uiView: MemojiKeyboardTextField, context: Context) {
  }
  
  func makeCoordinator() -> MemojiKeyboardTextFieldView.Coordinator {
    return Coordinator(onChosen: $onChosen)
  }
}
