import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ViewbarChart: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Data for the bar chart
        let data = [
                   BarChartData(value: 30, color: .red),
                   BarChartData(value: 20, color: .green),
                   BarChartData(value: 20, color: .darkGray),
                   BarChartData(value: 20, color: .cyan),
                   BarChartData(value: 30, color: .orange),
                   BarChartData(value: 20, color: .gray),
                   BarChartData(value: 50, color: .blue)
               ]
        ViewbarChart.data = data
    }
}

struct BarChartData {
    let value: CGFloat
    let color: UIColor
}

class BarChartView: UIView {
    
    var data: [BarChartData] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Failed to get the current graphics context")
            return
        }
        
        let maxValue = data.reduce(0) { max($0, $1.value) }
        let barCount = CGFloat(data.count)
        let spacing: CGFloat = 10
        
        let totalSpacing = spacing * (barCount - 1)
        let availableWidth = bounds.width - totalSpacing
        let barWidth: CGFloat = 30
        let cornerRadius: CGFloat = 8 // Adjust the corner radius as needed
        
        let actualBarWidth = min(barWidth, availableWidth / barCount)
        let actualSpacing = (bounds.width - actualBarWidth * barCount) / (barCount - 1)
        
        let startX = (bounds.width - (actualBarWidth * barCount + actualSpacing * (barCount - 1))) / 2
        var currentX = startX
        
        for barData in data {
            let barHeight = bounds.height * barData.value / maxValue
            let barY = bounds.height - barHeight
            
            let barRect = CGRect(x: currentX, y: barY, width: actualBarWidth, height: barHeight)
            
            let path = UIBezierPath(roundedRect: barRect, cornerRadius: cornerRadius)
            
            barData.color.setFill()
            path.fill()
            
            currentX += actualBarWidth + actualSpacing
        }
    }
}






