//
//  YAMLTextView.swift
//  StubbyEditor
//
//  Created by Andras Olah on 2025. 03. 29..
//

import SwiftUI
import AppKit

struct YAMLTextView: NSViewRepresentable {
    var text: String

    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.autohidesScrollers = true

        let textView = NSTextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true
        textView.autoresizingMask = [.width]
        textView.usesFindBar = true
        textView.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        textView.textColor = .labelColor
        textView.backgroundColor = .textBackgroundColor

        scrollView.documentView = textView
        return scrollView
    }

    func updateNSView(_ nsView: NSScrollView, context: Context) {
        guard let textView = nsView.documentView as? NSTextView else { return }
        if textView.string != text {
            textView.string = text
        }
    }
}

#Preview {
    YAMLTextView(text: """
    # Sample YAML
    upstream_recursive_servers:
      - address_data: 1.1.1.1
        tls_auth_name: "cloudflare-dns.com"
    """)
    .frame(width: 400, height: 300)
}
