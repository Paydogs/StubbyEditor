//
//  HeaderView.swift
//  StubbyEditor
//
//  Created by Andras Olah on 2025. 03. 29..
//

import SwiftUI

struct HeaderView: View {
    var selectedFilePath: String?
    var onOpenFile: () -> Void
    var entryCount: Int?

    var body: some View {
        HStack {
            Button("Open YAML File", action: onOpenFile)

            if let path = selectedFilePath {
                Text(path)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.middle)
            } else {
                Text("No file selected")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            if let count = entryCount, count > 0 {
                Text("Entries: \(count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(8)
    }
}

#Preview {
    VStack(spacing: 0) {
        HeaderView(
            selectedFilePath: "/Users/you/Configs/stubby4node.yaml",
            onOpenFile: { print("Open file clicked") },
            entryCount: 12
        )
        Divider()
    }
    .frame(width: 700)
}
