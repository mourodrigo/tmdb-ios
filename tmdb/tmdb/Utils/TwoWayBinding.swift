//  TwoWayBinding.swift
//  tmdb

import Foundation
import RxSwift
import RxCocoa

/// This allow to a two way binding between any BehaviorRelay and a ControlProperty of a UIComponent
/// e.g.
/// (<component>.rx.text <-> <BehaviorRelay>).disposed(by: disposeBag)

infix operator <->
func <-> <T>(property: ControlProperty<T>, variable: BehaviorRelay<T>) -> Disposable {

    let variableToProperty = variable
        .asObservable()
        .bind(to: property)

    let propertyToVariable = property.subscribe(
        onNext: { value in
            variable.accept(value)
        },
        onCompleted: {
            variableToProperty.dispose()
        }
    )
    return CompositeDisposable(variableToProperty, propertyToVariable)
}
