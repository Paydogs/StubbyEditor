//
//  ContentView.swift
//  StubbyEditor
//
//  Created by Andras Olah on 2025. 03. 29..
//

import SwiftUI
import UniformTypeIdentifiers
import Yams

struct ContentView: View {
    @State private var selectedFilePath: String? = nil
    @State private var fileContents: String = ""
    @State private var stubbyEntries: [StubbyEntry] = []

    var body: some View {
        VStack(spacing: 0) {
            HeaderView(
                selectedFilePath: selectedFilePath,
                onOpenFile: openYAMLFile,
                entryCount: stubbyEntries.count
            )
            Divider()
            HSplitView {
                YAMLTextView(text: fileContents)
                    .frame(minWidth: 300, maxWidth: .infinity, maxHeight: .infinity)

                VStack {
                    Text("🛠 Editor / Preview")
                        .foregroundColor(.secondary)
                }
                .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(minWidth: 700, minHeight: 400)
    }

    func openYAMLFile() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.allowedContentTypes = [.yaml, .plainText]

        if panel.runModal() == .OK, let url = panel.url {
            selectedFilePath = url.path

            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let content = try String(contentsOf: url, encoding: .utf8)

                    DispatchQueue.main.async {
                        fileContents = content

                        do {
                            let decoder = YAMLDecoder()
                            let parsed = try decoder.decode([StubbyEntry].self, from: content)
                            stubbyEntries = parsed

                            print("✅ Parsed \(parsed.count) stubby entries:")
                            for entry in parsed {
                                print("- \(entry.request.method) \(entry.request.url)")
                            }
                        } catch {
                            print("❌ Failed to parse YAML: \(error)")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        fileContents = "⚠️ Failed to read file: \(error)"
                        print("❌ Failed to read file: \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

//extension UTType {
//    static let yaml = UTType(importedAs: "public.yaml")
//}
