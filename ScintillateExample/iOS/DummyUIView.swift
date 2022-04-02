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
    leButton.translatesAutoresizingMaskIntoConstraints = false

    addSubview(leButton)
    addSubview(stackView)
    stackView.addArrangedSubview(label)
    stackView.addArrangedSubview(image)

    NSLayoutConstraint.activate([
      leButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      leButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      leButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
      leButton.heightAnchor.constraint(equalToConstant: 52)
    ])

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: leButton.bottomAnchor),
      stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  @objc private func clapClap() {
    Scintillate.isOn ? Scintillate.shutDown(in: stackView) : Scintillate.kickStart(in: stackView)
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
