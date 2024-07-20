
import UIKit

final class MainViewController: UIViewController {
    
    private lazy var builder = {
        return ViewBuilder(controller: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        builder.getWeatherSlider()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.builder.selectRandomCell()
        }
    }
}
