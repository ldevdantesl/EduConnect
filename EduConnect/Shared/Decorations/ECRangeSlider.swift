//
//  ECRangeSlider.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.01.2026.
//

import UIKit

final class ECRangeSlider: UIControl {
    
    // MARK: - Properties
    var minimumValue: CGFloat = 100_000 {
        didSet { updateLayerFrames() }
    }
    
    var maximumValue: CGFloat = 10_000_000 {
        didSet { updateLayerFrames() }
    }
    
    var lowerValue: CGFloat = 100_000 {
        didSet { updateLayerFrames() }
    }
    
    var upperValue: CGFloat = 10_000_000 {
        didSet { updateLayerFrames() }
    }
    
    var stepValue: CGFloat = 10_000
    
    var trackTintColor: UIColor = .systemGray4 {
        didSet { trackLayer.setNeedsDisplay() }
    }
    
    var trackHighlightColor: UIColor = .systemBlue {
        didSet { trackLayer.setNeedsDisplay() }
    }
    
    var thumbColor: UIColor = .systemBlue {
        didSet {
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    private let trackLayer = ECRangeSliderTrackLayer()
    private let lowerThumbLayer = ECRangeSliderThumbLayer()
    private let upperThumbLayer = ECRangeSliderThumbLayer()
    
    private let lowerValueLabel = ECSliderValueLabel()
    private let upperValueLabel = ECSliderValueLabel()
    
    private var previousLocation = CGPoint()
    private let thumbWidth: CGFloat = 24
    private let thumbHeight: CGFloat = 30
    
    private var isDragging = false
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        lowerThumbLayer.rangeSlider = self
        lowerThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(lowerThumbLayer)
        
        upperThumbLayer.rangeSlider = self
        upperThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperThumbLayer)
        
        addSubview(lowerValueLabel)
        addSubview(upperValueLabel)
        
        updateLayerFrames()
    }
    
    override var frame: CGRect {
        didSet { updateLayerFrames() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayerFrames()
    }
    
    private func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let trackHeight: CGFloat = 2
        let trackY = (bounds.height - trackHeight) / 2 + 10
        trackLayer.frame = CGRect(x: thumbWidth / 2, y: trackY, width: bounds.width - thumbWidth, height: trackHeight)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbX = positionForValue(lowerValue) - thumbWidth / 2
        lowerThumbLayer.frame = CGRect(x: lowerThumbX, y: trackY - thumbHeight + trackHeight / 2, width: thumbWidth, height: thumbHeight)
        lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbX = positionForValue(upperValue) - thumbWidth / 2
        upperThumbLayer.frame = CGRect(x: upperThumbX, y: trackY - thumbHeight + trackHeight / 2, width: thumbWidth, height: thumbHeight)
        upperThumbLayer.setNeedsDisplay()
        
        updateValueLabels()
        
        CATransaction.commit()
    }
    
    private func updateValueLabels() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        
        lowerValueLabel.text = formatter.string(from: NSNumber(value: lowerValue))
        upperValueLabel.text = formatter.string(from: NSNumber(value: upperValue))
        
        lowerValueLabel.sizeToFit()
        upperValueLabel.sizeToFit()
        
        let labelY = lowerThumbLayer.frame.minY - lowerValueLabel.bounds.height - 4
        
        lowerValueLabel.center = CGPoint(x: lowerThumbLayer.frame.midX, y: labelY + lowerValueLabel.bounds.height / 2)
        upperValueLabel.center = CGPoint(x: upperThumbLayer.frame.midX, y: labelY + upperValueLabel.bounds.height / 2)
    }
    
    private func positionForValue(_ value: CGFloat) -> CGFloat {
        let trackWidth = bounds.width - thumbWidth
        return thumbWidth / 2 + trackWidth * (value - minimumValue) / (maximumValue - minimumValue)
    }
    
    private func valueForPosition(_ position: CGFloat) -> CGFloat {
        let trackWidth = bounds.width - thumbWidth
        let percentage = (position - thumbWidth / 2) / trackWidth
        let rawValue = minimumValue + (maximumValue - minimumValue) * percentage
        
        // Round to nearest step
        return round(rawValue / stepValue) * stepValue
    }
    
    // MARK: - Touch handling
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        let lowerHitArea = lowerThumbLayer.frame.insetBy(dx: -15, dy: -15)
        let upperHitArea = upperThumbLayer.frame.insetBy(dx: -15, dy: -15)
        
        if lowerHitArea.contains(previousLocation) {
            lowerThumbLayer.isHighlighted = true
            isDragging = true
        } else if upperHitArea.contains(previousLocation) {
            upperThumbLayer.isHighlighted = true
            isDragging = true
        }
        
        return isDragging
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard isDragging else { return false }
        
        let location = touch.location(in: self)
        
        if lowerThumbLayer.isHighlighted {
            let newValue = valueForPosition(location.x)
            lowerValue = boundValue(newValue, min: minimumValue, max: upperValue - stepValue)
        } else if upperThumbLayer.isHighlighted {
            let newValue = valueForPosition(location.x)
            upperValue = boundValue(newValue, min: lowerValue + stepValue, max: maximumValue)
        }
        
        sendActions(for: .valueChanged)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.isHighlighted = false
        upperThumbLayer.isHighlighted = false
        isDragging = false
    }
    
    override func cancelTracking(with event: UIEvent?) {
        lowerThumbLayer.isHighlighted = false
        upperThumbLayer.isHighlighted = false
        isDragging = false
    }
    
    private func boundValue(_ value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        return Swift.min(Swift.max(value, min), max)
    }
    
    // MARK: - Gesture handling to prevent scroll interference
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let location = gestureRecognizer.location(in: self)
        let lowerHitArea = lowerThumbLayer.frame.insetBy(dx: -15, dy: -15)
        let upperHitArea = upperThumbLayer.frame.insetBy(dx: -15, dy: -15)
        
        return lowerHitArea.contains(location) || upperHitArea.contains(location)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let lowerHitArea = lowerThumbLayer.frame.insetBy(dx: -15, dy: -15)
        let upperHitArea = upperThumbLayer.frame.insetBy(dx: -15, dy: -15)
        
        return lowerHitArea.contains(point) || upperHitArea.contains(point)
    }
}

// MARK: - Track Layer
final class ECRangeSliderTrackLayer: CALayer {
    weak var rangeSlider: ECRangeSlider?
    
    override func draw(in ctx: CGContext) {
        guard let slider = rangeSlider else { return }
        
        // Track background
        ctx.setFillColor(slider.trackTintColor.cgColor)
        ctx.fill(bounds)
        
        // Highlighted track
        let lowerX = CGFloat(slider.lowerValue - slider.minimumValue) / CGFloat(slider.maximumValue - slider.minimumValue) * bounds.width
        let upperX = CGFloat(slider.upperValue - slider.minimumValue) / CGFloat(slider.maximumValue - slider.minimumValue) * bounds.width
        
        ctx.setFillColor(slider.trackHighlightColor.cgColor)
        ctx.fill(CGRect(x: lowerX, y: 0, width: upperX - lowerX, height: bounds.height))
    }
}

// MARK: - Thumb Layer (Arrow style)
final class ECRangeSliderThumbLayer: CALayer {
    weak var rangeSlider: ECRangeSlider?
    var isHighlighted: Bool = false
    
    override func draw(in ctx: CGContext) {
        guard let slider = rangeSlider else { return }
        
        let color = slider.thumbColor
        ctx.setFillColor(color.cgColor)
        
        // Draw arrow pointing down
        let path = UIBezierPath()
        let midX = bounds.midX
        let arrowWidth: CGFloat = bounds.width
        let arrowHeight: CGFloat = bounds.height
        
        path.move(to: CGPoint(x: midX - arrowWidth / 2, y: 0))
        path.addLine(to: CGPoint(x: midX + arrowWidth / 2, y: 0))
        path.addLine(to: CGPoint(x: midX + arrowWidth / 2, y: arrowHeight * 0.6))
        path.addLine(to: CGPoint(x: midX, y: arrowHeight))
        path.addLine(to: CGPoint(x: midX - arrowWidth / 2, y: arrowHeight * 0.6))
        path.close()
        
        ctx.addPath(path.cgPath)
        ctx.fillPath()
    }
}

// MARK: - Value Label
final class ECSliderValueLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        font = ECFont.font(.semiBold, size: 12)
        textColor = .white
        textAlignment = .center
        backgroundColor = .systemBlue
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 12, height: size.height + 6)
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)
        super.drawText(in: rect.inset(by: insets))
    }
}
