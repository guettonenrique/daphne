import Foundation

// MARK: - Placeholder Note Model

struct MockNote: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var filename: String
    var snippet: String
    var date: String
    var content: String
    var tags: [String]
}

// MARK: - Placeholder Content

extension MockNote {
    static let placeholders: [MockNote] = [
        MockNote(
            title: "Daphne Architecture",
            filename: "daphne_architecture.md",
            snippet: "Native macOS & iOS note app with a sleek dev-first aesthetic inspired by Warp & Vercel...",
            date: "2026-09-21",
            content: """
            # Daphne Architecture
            
            A developer-first, high-performance note app built natively with SwiftUI.
            
            ## Key Concepts
            - Warp Terminal "Block" aesthetic
            - Deep obsidian palette with 1px tech borders
            - Monospaced typography & terminal prompt paths
            
            ```swift
            struct DaphneTheme {
                static let green = Color(hex: "#00E575")
                static let obsidian = Color(hex: "#0A0D10")
            }
            ```
            """,
            tags: ["swift", "arch", "macos"]
        ),
        MockNote(
            title: "Docker Compose Setups",
            filename: "docker_snippets.sh",
            snippet: "docker compose up -d --build and helpful container debugging tricks...",
            date: "2026-09-20",
            content: """
            # Docker Cheatsheet
            
            Quick shortcuts for dev containers:
            
            ```bash
            # Start background stack
            docker compose up -d --build
            
            # Formatted status check
            docker ps --format "table {{.Names}}\\t{{.Status}}\\t{{.Ports}}"
            ```
            """,
            tags: ["docker", "devops"]
        ),
        MockNote(
            title: "Command Palette Specs",
            filename: "command_palette.md",
            snippet: "Trigger with ⌘K, fuzzy search actions, tags, and quick note switching...",
            date: "2026-09-18",
            content: """
            # Command Palette (⌘K)
            
            - Instant fuzzy search across notes
            - Quick actions (Export, New Tag, Switch Folder)
            - Keyboard navigation with ↑/↓ and Enter
            """,
            tags: ["ui", "warp"]
        )
    ]
}
