//
//  DummyUIView.swift
//  ScintillateExample (iOS)
//
//  Created by Alex Lee on 4/1/22.
//

import Foundation
import UIKit
import SwiftUI
import Scintillate

class DummyUIView: UIView {
  private lazy var stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .fill
    stack.spacing = 8
    stack.translatesAutoresizingMaskIntoConstraints = false

    return stack
  }()

  private lazy var animateSwitch: UIView = {
    let leSwitch = UISwitch()
    leSwitch.addTarget(self, action: #selector(sonOfASwitchAnimate), for: .valueChanged)
    leSwitch.setContentCompressionResistancePriority(.required, for: .horizontal)

    let label = UILabel()
    label.font = .systemFont(ofSize: 10)
    label.text = "animate"
    label.setContentCompressionResistancePriority(.required, for: .horizontal)

    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fill
    stack.addArrangedSubview(label)
    stack.addArrangedSubview(leSwitch)

    return stack
  }()

  private lazy var gradientSwitch: UIView = {
    let leSwitch = UISwitch()
    leSwitch.addTarget(self, action: #selector(sonOfASwitchGradient), for: .valueChanged)
    leSwitch.setContentCompressionResistancePriority(.required, for: .horizontal)

    let label = UILabel()
    label.font = .systemFont(ofSize: 10)
    label.text = "gradient"
    label.setContentCompressionResistancePriority(.required, for: .horizontal)

    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .fill
    stack.addArrangedSubview(label)
    stack.addArrangedSubview(leSwitch)

    return stack
  }()

  private var shouldAnimate = false
  private var shouldUseGradient = false

  required init?(coder: NSCoder) {
    fatalError("wtf coder")
  }

  init() {
    super.init(frame: .zero)

    let label = UILabel()
    label.font = .systemFont(ofSize: 24, weight: .bold)
    label.text = "HELLO THERE"
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)

    let image = UIImageView(image: UIImage(systemName: "hands.clap.fill"))
    image.contentMode = .scaleAspectFit

    let leButton = UIButton(type: .system)
    leButton.addTarget(self, action: #selector(clapClap), for: .touchUpInside)
    leButton.setTitle("toggle Scintillate", for: .normal)

    let switchStack = UIStackView()
    switchStack.axis = .vertical
    switchStack.distribution = .fill

    let controlStack = UIStackView()
    controlStack.axis = .horizontal
    controlStack.distribution = .fill
    controlStack.translatesAutoresizingMaskIntoConstraints = false

    addSubview(controlStack)
    addSubview(stackView)

    switchStack.addArrangedSubview(animateSwitch)
    switchStack.addArrangedSubview(gradientSwitch)
    controlStack.addArrangedSubview(leButton)
    controlStack.addArrangedSubview(switchStack)

    stackView.addArrangedSubview(label)
    stackView.addArrangedSubview(image)

    NSLayoutConstraint.activate([
      controlStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      controlStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      controlStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8)
    ])

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: controlStack.bottomAnchor, constant: 8),
      stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  @objc private func clapClap() {
    let settings = ScintillateSettings(
      shouldAnimate: shouldAnimate,
      secondaryColor: shouldUseGradient ? .scintillateDefaultShineComplement : nil)

    Scintillate.isOn ? Scintillate.shutDown(in: stackView) : Scintillate.kickStart(in: stackView, with: settings)

    animateSwitch.isUserInteractionEnabled = !Scintillate.isOn
    animateSwitch.alpha = Scintillate.isOn ? 0.3 : 1
    gradientSwitch.isUserInteractionEnabled = !Scintillate.isOn
    gradientSwitch.alpha = Scintillate.isOn ? 0.3 : 1
  }

  @objc private func sonOfASwitchAnimate(_ sandSwitch: UISwitch) {
    shouldAnimate = sandSwitch.isOn
  }

  @objc private func sonOfASwitchGradient(_ sandSwitch: UISwitch) {
    shouldUseGradient = sandSwitch.isOn
  }
}

struct UIViewProvider: UIViewRepresentable {
  var viewProvider: () -> UIView

  init(viewProvider: @escaping () -> UIView) {
    self.viewProvider = viewProvider
  }

  func makeUIView(context: Context) -> UIView {
    viewProvider()
  }

  func updateUIView(_ uiView: UIView, context: Context) { }
}
