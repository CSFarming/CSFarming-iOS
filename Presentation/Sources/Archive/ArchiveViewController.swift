//
//  ArchiveViewController.swift
//  CSFarming
//
//  Created by 홍성준 on 12/3/23.
//

import RIBs
import RxSwift
import UIKit

protocol ArchivePresentableListener: AnyObject {}

final class ArchiveViewController: UIViewController, ArchivePresentable, ArchiveViewControllable {
    
    weak var listener: ArchivePresentableListener?
    
}
