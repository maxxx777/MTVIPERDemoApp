//
//  MTCountryListWireframe.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCountryListWireframe.h"
#import "MTCityListModuleInterface.h"
#import "MTCountryWebService.h"
#import "MTFetchedResultsControllerBasedItemListCache.h"
#import "MTArrayBasedItemListCache.h"
#import "MTCountryDataManager.h"
#import "MTCountryListRequester.h"
#import "MTItemListFetcher.h"
#import "MTItemListSearcher.h"
#import "MTCountryListSearchPresenter.h"
#import "MTCountryListTablePresenter.h"
#import "MTCountryListPresenter.h"
#import "MTItemListSearchViewController.h"
#import "MTItemListTableViewController.h"
#import "MTItemListViewController.h"

@interface MTCountryListWireframe ()

@property (nonatomic, strong) MTItemListViewController *viewController;

@end

@implementation MTCountryListWireframe

#pragma mark - MTCountryListModuleInterface

- (void)showCountryListViewInWindow:(UIWindow *)window
{
    //init
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    _viewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListViewControllerWithSearch"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    //configure
    [self configureStack];
    
    //navigate
    window.rootViewController = navigationController;
}

#pragma mark - Public

- (void)onDidSelectCountry:(id __nonnull)country
{
    [self.cityListModule selectCityWithCountry:country
                          navigationController:self.viewController.navigationController];
}

#pragma mark - Helper

- (void)configureStack
{
    //init web serice
    MTCountryWebService *countryWebService = [[MTCountryWebService alloc] init];
    
    //init cache
    MTFetchedResultsControllerBasedItemListCache *itemListCache = [[MTFetchedResultsControllerBasedItemListCache alloc] init];
    MTArrayBasedItemListCache *searchResultsCache = [[MTArrayBasedItemListCache alloc] init];
    
    //init data manager
    MTCountryDataManager *countryDataManager = [[MTCountryDataManager alloc] init];
    
    //init interactor
    MTCountryListRequester *countryListRequester = [[MTCountryListRequester alloc]
                                                    initWithMainItemListCache:itemListCache
                                                    searchResultsCache:searchResultsCache
                                                    countryDataManager:countryDataManager];
    MTItemListFetcher *itemListFetcher = [[MTItemListFetcher alloc]
                                          initWithItemListCache:itemListCache
                                          rootDataManager:countryDataManager];
    MTItemListSearcher *itemListSearcher = [[MTItemListSearcher alloc]
                                            initWithSearchResultsCache:searchResultsCache
                                            rootDataManager:countryDataManager];
    
    //init presenter
    MTCountryListSearchPresenter *countryListSearchPresenter = [[MTCountryListSearchPresenter alloc]
                                                                initWithItemListRequester:countryListRequester
                                                                itemListSearcher:itemListSearcher
                                                                wireframe:self];
    MTCountryListTablePresenter *countryListTablePresenter = [[MTCountryListTablePresenter alloc]
                                                              initWithItemListRequester:countryListRequester
                                                              itemListFetcher:itemListFetcher
                                                              wireframe:self];
    MTCountryListPresenter *countryListPresenter = [[MTCountryListPresenter alloc] initWithWireframe:self];
    
    //init view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    MTItemListSearchViewController *itemListSearchViewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListSearchViewController"];
    MTItemListTableViewController *itemListTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListTableViewController"];
    itemListTableViewController.enableIndexedList = YES;
    itemListTableViewController.enablePullToRefresh = YES;
    
    //bind view controller
    self.viewController.childTableViewController = itemListTableViewController;
    self.viewController.searchViewController = itemListSearchViewController;
    self.viewController.presenter = countryListPresenter;
    itemListTableViewController.presenter = countryListTablePresenter;
    itemListSearchViewController.presenter = countryListSearchPresenter;
    
    //bind presenter
    countryListPresenter.userInterface = self.viewController;
    countryListTablePresenter.userInterface = itemListTableViewController;
    countryListSearchPresenter.userInterface = itemListSearchViewController;
    
    //bind interactor
    countryListRequester.outputs = @[countryListTablePresenter];
    itemListFetcher.outputs = @[countryListTablePresenter];
    itemListSearcher.outputs = @[countryListSearchPresenter];
    
    //bind data manager
    countryDataManager.countryWebService = countryWebService;
}

@end
