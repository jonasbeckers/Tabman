//
//  BarOptionButton.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 16/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
@testable import Tabman

private struct Defaults {
    static let barItemCount = 3
}

final class BarOptionButton<BarType: TMBar>: UIButton {
    
    let barContainer = UIView()
    let bar = BarType()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        
        addSubview(barContainer)
        barContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            barContainer.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            trailingAnchor.constraint(equalTo: barContainer.trailingAnchor, constant: 20.0),
            bottomAnchor.constraint(equalTo: barContainer.bottomAnchor, constant: 12.0)
            ])
        
        let barView = bar as UIView
        barContainer.addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: barContainer.leadingAnchor),
            barView.topAnchor.constraint(equalTo: barContainer.topAnchor),
            barView.trailingAnchor.constraint(equalTo: barContainer.trailingAnchor),
            barView.bottomAnchor.constraint(equalTo: barContainer.bottomAnchor)
            ])
        
        bar.dataSource = self
        bar.reloadData(at: 0 ... Defaults.barItemCount - 1,
                       context: .full)
        bar.update(for: 0.0,
                   capacity: Defaults.barItemCount,
                   direction: .none,
                   animation: TMBarAnimation(isEnabled: false, duration: 0.0))
        
        layer.borderColor = tintColor.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 12.0

        backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    }
}

extension BarOptionButton: TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItem {
        return TMBarItem(title: "Page \(index + 1)")
    }
}
