# Swift Markdown HTML

A small Markdown → HTML renderer built on Apple's [swift-markdown](https://github.com/apple/swift-markdown) (cmark-gfm). Give it a CommonMark + GitHub-Flavored-Markdown string and get back an HTML fragment — one static call, no configuration.

## Features

- 📝 **CommonMark** — headings, paragraphs, emphasis, lists, block quotes, code
- 🐙 **GitHub-Flavored** — tables, task lists, strikethrough
- 🔗 **Links & images** — with attribute escaping
- 🧱 **Code blocks** — fenced blocks emit `class="language-…"` for syntax highlighting
- 🛡️ **HTML-escaped** — text and code are escaped; raw HTML in the source passes through
- 🪶 **One dependency** — Apple's swift-markdown
- 🍎 **Cross-platform** — iOS, macOS, tvOS, watchOS, visionOS

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+ / visionOS 1.0+
- Swift 5.9+

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/arraypress/swift-markdown-html.git", branch: "main")
]
```

## Usage

```swift
import MarkdownHTML

let html = MarkdownHTML.render("""
# Hello

Some **bold** text and a [link](https://apple.com).

- [x] shipped
- [ ] todo
""")

print(html)
// <h1>Hello</h1>
// <p>Some <strong>bold</strong> text and a <a href="https://apple.com">link</a>.</p>
// <ul>
// <li class="task"><input type="checkbox" disabled checked>shipped</li>
// <li class="task"><input type="checkbox" disabled>todo</li>
// </ul>
```

## License

MIT
