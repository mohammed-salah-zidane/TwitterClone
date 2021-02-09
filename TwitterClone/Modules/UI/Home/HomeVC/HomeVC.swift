//
//  HomeVC.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/7/21.
//

import UIKit

class HomeVC: BaseWireframe<HomeVM, Coordinator>  {
    
    //MARK:- Properties
    @IBOutlet weak var tableView: PagedTableView!{
        didSet {
            setupTableView()
        }
    }
    
    //MARK:- Variables
    private lazy var pager: Pager = {
        Pager.Builder()
            .loadMore { [weak self] next in
                guard let self = self else {
                    return
                }
                self.viewModel.getFollowers(cursor: next)
            }
            .withScrollButton()
            .withRefresher()
            .build()
    }()
    
    private lazy var homeDataSrc: HomeDataSrc! = {
        let src = HomeDataSrc()
        src.onItemSelected = { [weak self] indexPath in
            guard let self = self else {
                return
            }
            
        }
        return src
    }()
    
    private var menu: NavDropMenu!
    
    //MARK:- LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- Ovverides
    override func bind(viewModel: HomeVM) {
        viewModel
            .hasFollowersFetched
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
                self?.updateDataSrc()
            }).disposed(by: disposeBag)
        
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
                self?.setupUI()
                self?.pager.start(reset: true)
            }).disposed(by: disposeBag)
        
        viewModel
            .navigateToAuth
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{ state in
                guard state else {return}
                execute(After: 0.2) {[weak self] in
                    self?.coordinator.auth.navigate(to: .auth, with: .root)
                }
            }).disposed(by: disposeBag)
        
    }
    
}

extension HomeVC {
    
    func setupUI() {
        menu = NavDropMenu()
        menu.setup(
            title: viewModel.getCurrentUserName(),
            items: viewModel.getMenuItems(),
            navigationItem: navigationItem) {[weak self] selectedIndex in
            guard let self = self else {return}
            self.viewModel.selectItemInMenu(index: selectedIndex)
        }
    }
    
    func updateDataSrc() {
        self.homeDataSrc.items = viewModel.getFollowers() ?? []
        self.pager.notifyItemsLoaded(count: viewModel.getNextCursor())
        self.tableView.tableFooterView = UIView()
    }
    
    func setupTableView() {
        tableView.register(cell: UserCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.pagedDataSource = homeDataSrc
        tableView.pagedDelegate = homeDataSrc
        tableView.pager = pager
        pager.start()
    }
}
