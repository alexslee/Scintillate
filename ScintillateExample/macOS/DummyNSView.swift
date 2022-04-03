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
      self.layer?.contentsGravity = .resize
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
    stack.distribution = .fill
    stack.alignment = .width
    stack.spacing = 8
    stack.translatesAutoresizingMaskIntoConstraints = false

    return stack
  }()

  private lazy var animateToggle: NSButton = {
    let leButton = NSButton(checkboxWithTitle: "animate", target: self, action: #selector(sonOfASwitchAnimate))
    leButton.setContentCompressionResistancePriority(.required, for: .horizontal)

    return leButton
  }()

  private lazy var gradientToggle: NSButton = {
    let leButton = NSButton(checkboxWithTitle: "gradient", target: self, action: #selector(sonOfASwitchGradient))
    leButton.setContentCompressionResistancePriority(.required, for: .horizontal)

    return leButton
  }()

  private var shouldAnimate = false
  private var shouldUseGradient = false

  init() {
    super.init(frame: .zero)

    let button = NSButton(title: "toggle Scintillate", target: self, action: #selector(clapClap))

    let label = NSTextField(labelWithString: "HELLO THERE")
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.alignment = .left
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    let imageView = PainfulNSImageView(
      image: NSImage(systemSymbolName: "hands.clap.fill", accessibilityDescription: nil)!)
    imageView.setContentCompressionResistancePriority(.required, for: .vertical)
    imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    imageView.translatesAutoresizingMaskIntoConstraints = false

    let controlStack = NSStackView()
    controlStack.orientation = .horizontal
    controlStack.translatesAutoresizingMaskIntoConstraints = false

    addSubview(controlStack)
    addSubview(stackView)
    controlStack.addArrangedSubview(button)
    controlStack.addArrangedSubview(animateToggle)
    controlStack.addArrangedSubview(gradientToggle)
    stackView.addArrangedSubview(label)
    stackView.addArrangedSubview(imageView)

    imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true

    NSLayoutConstraint.activate([
      controlStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      controlStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      controlStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
    ])

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
      stackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  @objc private func clapClap() {
    let settings = ScintillateSettings(
      shouldAnimate: shouldAnimate,
      secondaryColor: shouldUseGradient ? .scintillateDefaultShineComplement : nil)
    Scintillate.isOn ? Scintillate.shutDown(in: stackView) : Scintillate.kickStart(in: stackView, with: settings)

    animateToggle.isEnabled = !Scintillate.isOn
    animateToggle.alphaValue = Scintillate.isOn ? 0.3 : 1
    gradientToggle.isEnabled = !Scintillate.isOn
    gradientToggle.alphaValue = Scintillate.isOn ? 0.3 : 1
  }

  @objc private func sonOfASwitchAnimate(_ sandSwitch: NSButton) {
    shouldAnimate = sandSwitch.state == .on
  }

  @objc private func sonOfASwitchGradient(_ sandSwitch: NSButton) {
    shouldUseGradient = sandSwitch.state == .on
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
