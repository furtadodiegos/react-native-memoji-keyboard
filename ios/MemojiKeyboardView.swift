import Foundation
import SwiftUI
import UIKit

@available(iOS 13.0, *)
struct MemojiKeyboardView: View {
    @State var onChosen: (([String: Any]) -> Void)

    var body: some View {
        MemojiKeyboardTextFieldView(onChosen: $onChosen)
          .frame(width: 0, height: 0)
    }
}
