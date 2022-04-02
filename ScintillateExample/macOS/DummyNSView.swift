//
//  DummyNSView.swift
//  ScintillateExample (macOS)
//
//  Created by Alex Lee on 4/1/22.
//

import Foundation
import AppKit
import SwiftUI
import Scintillate

class PainfulNSImageView: NSImageView {
  override var image: NSImage? {
    set {
      self.layer = CALayer()
      self.layer?.contentsGravity = .resizeAspect
      self.layer?.contents = newValue
      self.wantsLayer = true

      super.image = newValue
    }

    get {
      return super.image
    }
  }
}

class DummyNSView: NSView {
  required init?(coder: NSCoder) {
    fatalError("wtf coder")
  }

  private lazy var stackView: NSStackView = {
    let stack = NSStackView()
    stack.orientation = .vertical
    stack.spacing = 8
    stack.translatesAutoresizingMaskIntoConstraints = false

    return stack
  }()

  init() {
    super.init(frame: .zero)

    let button = NSButton(title: "toggle Scintillate", target: self, action: #selector(clapClap))

    let label = NSTextField(labelWithString: "HELLO THERE")
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)

    let imageView = PainfulNSImageView(
      image: NSImage(systemSymbolName: "hands.clap.fill", accessibilityDescription: nil)!)
    imageView.setContentCompressionResistancePriority(.required, for: .vertical)
    imageView.setContentHuggingPriority(.required, for: .vertical)

    button.translatesAutoresizingMaskIntoConstraints = false

    addSubview(button)
    addSubview(stackView)
    stackView.addArrangedSubview(label)
    stackView.addArrangedSubview(imageView)

    NSLayoutConstraint.activate([
      button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      button.heightAnchor.constraint(equalToConstant: 52)
    ])

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  @objc private func clapClap() {
    Scintillate.isOn ? Scintillate.shutDown(in: stackView) : Scintillate.kickStart(in: stackView)
  }
}

struct NSViewProvider: NSViewRepresentable {
  var viewProvider: () -> NSView

  init(viewProvider: @escaping () -> NSView) {
    self.viewProvider = viewProvider
  }

  func makeNSView(context: Context) -> NSView {
    viewProvider()
  }

  func updateNSView(_ uiView: NSView, context: Context) { }
}
