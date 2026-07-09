//
//  MarkdownHTMLTests.swift
//  Tests for SwiftMarkdownHTML
//
//  Created by David Sherlock on 7/9/26.
//

import XCTest
@testable import MarkdownHTML

final class MarkdownHTMLTests: XCTestCase {

    func testHeading() {
        let html = MarkdownHTML.render("# Hello")
        XCTAssertEqual(html, "<h1>Hello</h1>\n")
    }

    func testHeadingLevels() {
        XCTAssertTrue(MarkdownHTML.render("### Deep").contains("<h3>Deep</h3>"))
    }

    func testBold() {
        let html = MarkdownHTML.render("Some **bold** text.")
        XCTAssertTrue(html.contains("<strong>bold</strong>"))
        XCTAssertTrue(html.contains("<p>"))
    }

    func testEmphasis() {
        XCTAssertTrue(MarkdownHTML.render("An *italic* word.").contains("<em>italic</em>"))
    }

    func testUnorderedList() {
        // swift-markdown wraps each list item's content in a paragraph.
        let html = MarkdownHTML.render("- one\n- two")
        XCTAssertTrue(html.contains("<ul>"))
        XCTAssertTrue(html.contains("<li><p>one</p>"))
        XCTAssertTrue(html.contains("<li><p>two</p>"))
    }

    func testOrderedList() {
        let html = MarkdownHTML.render("1. first\n2. second")
        XCTAssertTrue(html.contains("<ol>"))
        XCTAssertTrue(html.contains("<li><p>first</p>"))
    }

    func testInlineCode() {
        XCTAssertTrue(MarkdownHTML.render("Use `let x = 1` here.").contains("<code>let x = 1</code>"))
    }

    func testFencedCodeBlock() {
        let html = MarkdownHTML.render("```swift\nlet x = 1\n```")
        XCTAssertTrue(html.contains("<pre><code class=\"language-swift\">"))
        XCTAssertTrue(html.contains("let x = 1"))
        XCTAssertTrue(html.contains("</code></pre>"))
    }

    func testLink() {
        let html = MarkdownHTML.render("[Apple](https://apple.com)")
        XCTAssertTrue(html.contains("<a href=\"https://apple.com\">Apple</a>"))
    }

    func testImage() {
        let html = MarkdownHTML.render("![alt text](img.png)")
        XCTAssertTrue(html.contains("<img src=\"img.png\" alt=\"alt text\">"))
    }

    func testStrikethrough() {
        XCTAssertTrue(MarkdownHTML.render("~~gone~~").contains("<del>gone</del>"))
    }

    func testBlockQuote() {
        XCTAssertTrue(MarkdownHTML.render("> quoted").contains("<blockquote>"))
    }

    func testThematicBreak() {
        XCTAssertTrue(MarkdownHTML.render("---").contains("<hr>"))
    }

    func testTable() {
        let md = """
        | A | B |
        | - | - |
        | 1 | 2 |
        """
        let html = MarkdownHTML.render(md)
        XCTAssertTrue(html.contains("<table>"))
        XCTAssertTrue(html.contains("<th>A</th>"))
        XCTAssertTrue(html.contains("<td>1</td>"))
    }

    func testTaskList() {
        let html = MarkdownHTML.render("- [x] done\n- [ ] todo")
        XCTAssertTrue(html.contains("<li class=\"task\"><input type=\"checkbox\" disabled checked>"))
        XCTAssertTrue(html.contains("<li class=\"task\"><input type=\"checkbox\" disabled>"))
    }

    func testHTMLEscaping() {
        let html = MarkdownHTML.render("a < b & c > d")
        XCTAssertTrue(html.contains("&lt;"))
        XCTAssertTrue(html.contains("&amp;"))
        XCTAssertTrue(html.contains("&gt;"))
    }

    func testAttributeEscaping() {
        let html = MarkdownHTML.render("[link](\"weird\")")
        XCTAssertTrue(html.contains("&quot;"))
    }

    func testRawInlineHTMLPassesThrough() {
        XCTAssertTrue(MarkdownHTML.render("text <span>raw</span> more").contains("<span>raw</span>"))
    }
}
