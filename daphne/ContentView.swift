import SwiftUI

// MARK: - Main Daphne UI (2-Column Shell)

struct ContentView: View {
    // UI State
    @State private var selectedNoteID: UUID?
    @State private var searchText: String = ""
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    // Placeholder Data
    @State private var notes: [MockNote] = MockNote.placeholders

    var filteredNotes: [MockNote] {
        if searchText.isEmpty {
            return notes
        }
        return notes.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.snippet.localizedCaseInsensitiveContains(searchText) ||
            $0.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            notesSidebarView
        } detail: {
            editorView
        }
        .navigationSplitViewStyle(.balanced)
        .toolbarBackground(DaphneTheme.windowBackground, for: .windowToolbar)
        .background(DaphneTheme.windowBackground)
        .onAppear {
            selectedNoteID = notes.first?.id
        }
    }

    // MARK: - 2. Notes Sidebar (Blocks List)
    private var notesSidebarView: some View {
        VStack(spacing: 10) {
            // Search Bar & New Note Button
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(.caption, design: .monospaced).bold())
                    .foregroundStyle(DaphneTheme.textSecondary)

                TextField("search notes or tags...", text: $searchText)
                    .font(.system(.subheadline, design: .monospaced))
                    .textFieldStyle(.plain)
                    .foregroundStyle(DaphneTheme.textPrimary)

                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.caption2)
                            .foregroundStyle(DaphneTheme.textMuted)
                    }
                    .buttonStyle(.plain)
                }

                // New Note Button (+)
                Button(action: createNewNote) {
                    Image(systemName: "plus")
                        .font(.system(.subheadline, design: .monospaced).bold())
                        .foregroundStyle(DaphneTheme.textPrimary)
                        .padding(4)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .help("New Note")
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 6)

            // Blocks List
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(filteredNotes) { note in
                        let isSelected = selectedNoteID == note.id

                        Button(action: { selectedNoteID = note.id }) {
                            VStack(alignment: .leading, spacing: 6) {
                                // Title & Date
                                HStack {
                                    Text(note.title)
                                        .font(.system(.subheadline, design: .monospaced).bold())
                                        .foregroundStyle(isSelected ? DaphneTheme.green : DaphneTheme.textPrimary)
                                        .lineLimit(1)
                                    Spacer()
                                    Text(note.date)
                                        .font(.system(size: 10, design: .monospaced))
                                        .foregroundStyle(DaphneTheme.textMuted)
                                }

                                // Snippet
                                Text(note.snippet)
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundStyle(DaphneTheme.textSecondary)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)

                                // Tags
                                HStack(spacing: 5) {
                                    ForEach(note.tags, id: \.self) { tag in
                                        Text("#\(tag)")
                                            .font(.system(size: 10, design: .monospaced))
                                            .foregroundStyle(DaphneTheme.textSecondary)
                                            .padding(.horizontal, 5)
                                            .padding(.vertical, 2)
                                            .background(Color.white.opacity(0.04))
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                    }
                                }
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .card(isSelected: isSelected)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
        }
        .background(DaphneTheme.sidebarBackground)
        #if os(macOS)
        .navigationSplitViewColumnWidth(min: 260, ideal: 300, max: 400)
        #endif
    }

    // MARK: - 3. Editor View
    @ViewBuilder
    private var editorView: some View {
        Group {
            if let id = selectedNoteID, let index = notes.firstIndex(where: { $0.id == id }) {
                TextEditor(text: $notes[index].content)
                    .font(.system(.body, design: .monospaced))
                    .foregroundStyle(DaphneTheme.textPrimary)
                    .padding(16)
                    .scrollContentBackground(.hidden)
            } else {
                Text("No note selected")
                    .font(.system(.subheadline, design: .monospaced))
                    .foregroundStyle(DaphneTheme.textMuted)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DaphneTheme.windowBackground)
    }

    // MARK: - Actions
    private func createNewNote() {
        let count = notes.count + 1
        let newNote = MockNote(
            title: "Untitled Note \(count)",
            filename: "untitled_\(count).md",
            snippet: "Start typing markdown here...",
            date: "Just now",
            content: "# Untitled Note \(count)\n\nStart writing...",
            tags: ["draft"]
        )
        notes.insert(newNote, at: 0)
        selectedNoteID = newNote.id
    }
}

#Preview {
    ContentView()
}

