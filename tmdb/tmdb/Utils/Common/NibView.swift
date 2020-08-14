//
//  NibView.swift
//  tmdb

import Foundation
import UIKit
import Cartography

/// A NibView is a view wrapper tha loads a XIB with the same name of the class and add it to itself.
@IBDesignable
class NibView: UIView {

    //************************************************
    // MARK: - Properties
    //************************************************

    private(set) weak var contentView: UIView?

    /// Called in the default implementation of loadNib(). Default is class name.
    ///
    /// - returns: Name of a single view nib file.
    var nibName: String {
        guard let name = type(of: self).description().components(separatedBy: ".").last else {
            fatalError("Invalid module name")
        }
        return name
    }

    //************************************************
    // MARK: - Lifecycle
    //************************************************

    init() {
        super.init(frame: CGRect.zero)
        self.setupNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }

    func viewDidLoad() {
        // can be implemented by descendants classes
    }

    //************************************************
    // MARK: - Nib loading
    //************************************************

    /// Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
    private func setupNib() {
        let nibView = self.loadNib()
        contentView = nibView

        self.addSubview(nibView)
        Cartography.constrain(nibView, self) { (view, container) in view.edges == container.edges }

        viewDidLoad()
    }

    /// Called to load the nib in setupNib().
    ///
    /// - returns: UIView instance loaded from a nib file.
    private func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView  else {
            fatalError("You're trying to load a NibDesignable without the respective nib file")
        }

        return view
    }
}
