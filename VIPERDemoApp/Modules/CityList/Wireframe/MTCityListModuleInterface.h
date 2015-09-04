//
//  MTCityListModuleInterface.h
//  VIPERDemoApp
//
//  Created by MAXIM TSVETKOV on 27.08.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

@protocol MTCityListModuleInterface <NSObject>

- (void)selectCityWithCountry:(id)country
         navigationController:(UINavigationController *)navigationController;

@end
