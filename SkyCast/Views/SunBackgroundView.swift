//
//  WeatherBackgroundView.swift
//  SkyCast
//
//  Created by Василий Тихонов on 16.07.2024.
//
import UIKit

class SunBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        addSunView()
        addCloudView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(red: 68/255, green: 121/255, blue: 219/255, alpha: 1).cgColor,
            UIColor(red: 111/255, green: 175/255, blue: 243/255, alpha: 1).cgColor,
            UIColor(red: 190/255, green: 223/255, blue: 255/255, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        self.layer.addSublayer(gradientLayer)
    }
    
    private func addSunView() {
        let sunView = SunView(frame: self.bounds)
        self.addSubview(sunView)
    }
    
    private func addCloudView() {
        let cloudView = CloudView(frame: self.bounds)
        self.addSubview(cloudView)
    }
}

class SunView: UIView {
    
    private let sunLayer = CALayer()
    private let sunEffectLayer = CAEmitterLayer()
    
    private var displayLink: CADisplayLink?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSunLayer()
        setupSunEffectLayer()
        startDisplayLink()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSunLayer()
        setupSunEffectLayer()
        startDisplayLink()
    }
    
    private func setupSunLayer() {
        sunLayer.frame = CGRect(x: 160, y: -100, width: 380, height: 380)
        sunLayer.contents = UIImage(named: "sun")?.cgImage
        self.layer.addSublayer(sunLayer)
    }
    
    private func setupSunEffectLayer() {
        sunEffectLayer.emitterPosition = sunLayer.position
        sunEffectLayer.emitterShape = .circle
        sunEffectLayer.emitterSize = CGSize(width: 80, height: 80)
        
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "sun_glow")?.cgImage
        /*
         cell.birthRate = 0.2  // Указывает количество испускаемых объектов, создаваемых каждую секунду. Коэффициент рождаемости, равный 0,2, означает, что каждые 5 секунд будет создаваться одна частица (поскольку 1/0,2 = 5).
         cell.lifetime = 5.0   // Определяет продолжительность жизни каждой частицы в секундах. Время жизни, равное 5,0, означает, что каждая частица будет существовать в течение 5 секунд, прежде чем исчезнет.
         cell.velocity = 15   // Задает начальную скорость испускаемых частиц. Скорость, равная 15 единицам в секунду, указывает, с какой скоростью будут двигаться частицы.
         cell.velocityRange = 5 // Увеличивает вариабельность скорости. Фактическая скорость каждой частицы будет находиться в диапазоне от (скорость - диапазон скоростей) до (скорость + диапазон скоростей), т.е. от 10 до 20 единиц в секунду.
         cell.scale = 0.2 // Задает начальный масштаб частиц. Масштаб 0,2 означает, что размер частиц составит 20% от их первоначального размера.
         cell.scaleRange = 0.1 // Добавляет вариабельности масштабу. Фактический масштаб каждой частицы будет находиться в диапазоне от (scale - scaleRange) до (scale + scaleRange), т.е. от 0,1 до 0,3 (от 10% до 30% от их первоначального размера).
         cell.alphaSpeed = -0.02  // Определяет изменение прозрачности (альфа) частиц в секунду. Альфа-скорость, равная -0,02, означает, что частицы будут постепенно становиться более прозрачными, уменьшая свою прозрачность на 0,02 каждую секунду.
         cell.yAcceleration = -5  // Задает ускорение частиц по оси y. Отрицательное ускорение Y, равное -5, означает, что частицы будут двигаться вверх, имитируя эффект подъема или парения.
         cell.emissionRange = .pi * 2.0 // Определяет диапазон углов (в радианах), в пределах которых частицы могут испускаться. Значение .pi * 2.0 означает, что частицы могут испускаться во всех направлениях (на 360 градусов), создавая круговую диаграмму направленности излучения.
         */
        cell.birthRate = 0.2
        cell.lifetime = 5.0
        cell.velocity = 15
        cell.velocityRange = 5
        cell.scale = 0.2
        cell.scaleRange = 0.1
        cell.alphaSpeed = -0.02
        cell.yAcceleration = -5
        cell.emissionRange = .pi * 2.0 
        
        sunEffectLayer.emitterCells = [cell]
        self.layer.addSublayer(sunEffectLayer)
    }
    
    private func startDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateAnimation))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    @objc private func updateAnimation() {
        sunEffectLayer.setNeedsDisplay()
    }
    
    deinit {
        displayLink?.invalidate()
    }
}

class CloudView: UIView {
    
    private let cloudLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCloudLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCloudLayer()
    }
    
    private func setupCloudLayer() {
        cloudLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 200)
        cloudLayer.contents = UIImage(named: "cloudy sky")?.cgImage
        cloudLayer.opacity = 0.8
        self.layer.addSublayer(cloudLayer)
    }
}





