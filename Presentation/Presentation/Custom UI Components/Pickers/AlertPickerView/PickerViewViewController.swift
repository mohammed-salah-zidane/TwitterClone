import UIKit

public extension UIAlertController {
    
    /// Add a picker view
    ///
    /// - Parameters:
    ///   - values: values for picker view
    ///   - initialSelection: initial selection of picker view
    ///   - action: action for selected value of picker view
    public func addPickerView(values: PickerViewViewController.Values,  initialSelection: PickerViewViewController.Index? = nil, withSerchBar:Bool = false, action: PickerViewViewController.Action?) {
        let pickerView = PickerViewViewController(values: values, initialSelection: initialSelection, action: action,withSerchBar:withSerchBar)
        set(vc: pickerView, height: 216)
    }
}

final public class PickerViewViewController: UIViewController {
    
    public typealias Values = [[String]]
    public typealias Index = (column: Int, row: Int)
    public typealias Action = (_ vc: UIViewController, _ picker: UIPickerView, _ index: Index, _ values: Values) -> ()
    
    fileprivate var action: Action?
    fileprivate var values: Values = [[]]
    fileprivate var valuesBySearch: Values = [[]]
    fileprivate var initialSelection: Index?
    fileprivate var withSerchBar: Bool?

    fileprivate var isFromSearchArray: Bool?

    fileprivate lazy var pickerView: UIPickerView = {
        return $0
    }(UIPickerView())
    
    init(values: Values, initialSelection: Index? = nil, action: Action?,withSerchBar:Bool = false) {
        super.init(nibName: nil, bundle: nil)
        self.values = values
        self.initialSelection = initialSelection
        self.action = action
        self.withSerchBar = withSerchBar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
    }
    
    override public func loadView() {
        if self.withSerchBar == true {
            self.view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 16, height: 216))
            pickerView.frame = CGRect(x: 15, y: 50, width: UIScreen.main.bounds.width - 50, height: 216)
            let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 50))
            searchBar.searchTextField.placeholder = "Search".localized
            pickerView.delegate = self
            searchBar.delegate = self
            self.view.addSubview(searchBar)
            self.view.addSubview(pickerView)
            self.preferredContentSize.height = 216 + searchBar.width
            self.isFromSearchArray = false
        }else{
            view = pickerView
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let initialSelection = initialSelection, values.count > initialSelection.column, values[initialSelection.column].count > initialSelection.row {
            pickerView.selectRow(initialSelection.row, inComponent: initialSelection.column, animated: true)
        }
    }
}
extension PickerViewViewController : UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isFromSearchArray = searchText.count > 0
        valuesBySearch.removeAll()
        for objects in values {
            var temp = [String]()
            for obj in objects {
                if obj.contains(searchText){
                    temp.append(obj)
                }
            }
            valuesBySearch.append(temp)
        }
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(0, inComponent: 0, animated: true)
        self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 0)
    }
}
extension PickerViewViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // returns the number of 'columns' to display.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.isFromSearchArray == true ? valuesBySearch.count : values.count
    }
    
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.isFromSearchArray == true ? valuesBySearch[component].count : values[component].count
    }
    /*
     // returns width of column and height of row for each component.
     public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
     
     }
     
     public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
     
     }
     */
    
    // these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
    // for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
    // If you return back a different object, the old one will be released. the view will be centered in the row rect
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.isFromSearchArray == true ? valuesBySearch[component][row] : values[component][row]
    }
    /*
     public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
     // attributed title is favored if both methods are implemented
     }
     
     
     public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
     
     }
     */
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.isFromSearchArray == true {
            for value in values {
                for valueObj in value {
                    if valuesBySearch.count > 0 && valuesBySearch[component].count > 0 {
                        if valuesBySearch[component][row] == valueObj {
                            action?(self, pickerView, Index(column: values.indexes(of:value).first ?? 0, row: value.indexes(of: valueObj).first ?? 0), values)
                        }
                    }
                }
            }
        }else{
            action?(self, pickerView, Index(column: component, row: row), values)
        }
    }
}
