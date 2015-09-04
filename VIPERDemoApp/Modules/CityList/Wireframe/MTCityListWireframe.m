//
//  MTCityListWireframe.m
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTCityListWireframe.h"
#import "MTItemListViewController.h"
#import "MTItemListSearchViewController.h"
#import "MTItemListTableViewController.h"
#import "MTCityListPresenter.h"
#import "MTCityListSearchPresenter.h"
#import "MTCityListTablePresenter.h"
#import "MTItemListSearcher.h"
#import "MTItemListFetcher.h"
#import "MTCityListRequester.h"
#import "MTCityDataManager.h"
#import "MTArrayBasedItemListCache.h"
#import "MTFetchedResultsControllerBasedItemListCache.h"
#import "MTCityWebService.h"

@interface MTCityListWireframe ()

@property (nonatomic, weak) MTItemListViewController *viewController;

@end

@implementation MTCityListWireframe

#pragma mark - MTCityListModuleInterface

- (void)selectCityWithCountry:(id)country
         navigationController:(UINavigationController *)navigationController
{
    //init
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    _viewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListViewControllerWithSearch"];
    
    //configure
    [self configureStackWithCountry:country];
    
    //navigate
    [navigationController pushViewController:self.viewController
                                    animated:YES];
}

#pragma mark - Helper

- (void)configureStackWithCountry:(id)country
{
    //init web serice
    MTCityWebService *cityWebService = [[MTCityWebService alloc] init];
    
    //init cache
    MTFetchedResultsControllerBasedItemListCache *itemListCache = [[MTFetchedResultsControllerBasedItemListCache alloc] init];
    MTArrayBasedItemListCache *searchResultsCache = [[MTArrayBasedItemListCache alloc] init];
    
    //init data manager
    MTCityDataManager *cityDataManager = [[MTCityDataManager alloc] init];
    
    //init interactor
    MTCityListRequester *cityListRequester = [[MTCityListRequester alloc]
                                              initWithCountry:country
                                              mainItemListCache:itemListCache
                                              searchResultsCache:searchResultsCache
                                              cityDataManager:cityDataManager];
    MTItemListFetcher *itemListFetcher = [[MTItemListFetcher alloc]
                                          initWithItemListCache:itemListCache
                                          rootDataManager:cityDataManager];
    MTItemListSearcher *itemListSearcher = [[MTItemListSearcher alloc]
                                            initWithSearchResultsCache:searchResultsCache
                                            rootDataManager:cityDataManager];
    
    //init presenter
    MTCityListSearchPresenter *cityListSearchPresenter = [[MTCityListSearchPresenter alloc]
                                                                initWithItemListRequester:cityListRequester
                                                                itemListSearcher:itemListSearcher
                                                                wireframe:self];
    MTCityListTablePresenter *cityListTablePresenter = [[MTCityListTablePresenter alloc]
                                                              initWithItemListRequester:cityListRequester
                                                              itemListFetcher:itemListFetcher
                                                              wireframe:self];
    MTCityListPresenter *cityListPresenter = [[MTCityListPresenter alloc] initWithWireframe:self];
    
    //init view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Base" bundle: nil];
    MTItemListSearchViewController *itemListSearchViewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListSearchViewController"];
    MTItemListTableViewController *itemListTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"ItemListTableViewController"];
    itemListTableViewController.enableIndexedList = YES;
    itemListTableViewController.enablePullToRefresh = YES;
    
    //bind view controller
    self.viewController.childTableViewController = itemListTableViewController;
    self.viewController.searchViewController = itemListSearchViewController;
    self.viewController.presenter = cityListPresenter;
    itemListTableViewController.presenter = cityListTablePresenter;
    itemListSearchViewController.presenter = cityListSearchPresenter;
    
    //bind presenter
    cityListPresenter.userInterface = self.viewController;
    cityListTablePresenter.userInterface = itemListTableViewController;
    cityListSearchPresenter.userInterface = itemListSearchViewController;
    
    //bind interactor
    cityListRequester.outputs = @[cityListTablePresenter];
    itemListFetcher.outputs = @[cityListTablePresenter];
    itemListSearcher.outputs = @[cityListSearchPresenter];
    
    //bind data manager
    cityDataManager.cityWebService = cityWebService;
}

@end
