
#import "Zendesk.h"
// #import <SupportSDK/SupportSDK.h>
#import <SupportProvidersSDK/SupportProvidersSDK.h>
#import <ZendeskCoreSDK/ZendeskCoreSDK.h>
#import "React/RCTLog.h"
// #import <CommonUISDK/CommonUISDK.h>

@implementation Zendesk

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(init:(NSDictionary *)options) {
  [ZDKZendesk initializeWithAppId:options[@"appId"] clientId: options[@"clientId"] zendeskUrl: options[@"url"]];
  [ZDKSupport initializeWithZendesk: [ZDKZendesk instance]];
}

RCT_EXPORT_METHOD(setUserIdentity: (NSDictionary *)user) {
  if (user[@"token"]) {
    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCJwt alloc] initWithToken:user[@"token"]];
    [[ZDKZendesk instance] setIdentity:userIdentity];
  } else {
    id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:user[@"name"] email:user[@"email"]];
    [[ZDKZendesk instance] setIdentity:userIdentity];
  }
}

RCT_EXPORT_METHOD(getHelpCenter:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
//    ZDKHelpCenterOverviewContentModel *model = [ZDKHelpCenterOverviewContentModel defaultContent];
    ZDKHelpCenterProvider *provider = [ZDKHelpCenterProvider new];

    [provider getHelpCenterOverviewWithHelpCenterOverviewModel:[ZDKHelpCenterOverviewContentModel defaultContent]
                                                      callback:^(NSArray<ZDKHelpCenterCategoryViewModel *> *categories, NSError *error) {
        if (error) {
            reject(@"get_error", error.localizedDescription, nil);
        } else {
            __block NSArray *result = @[];
            
            [categories enumerateObjectsUsingBlock:^(ZDKHelpCenterCategoryViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                __block NSArray *sections = @[];

                [obj.sections enumerateObjectsUsingBlock:^(ZDKHelpCenterSectionViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    __block NSArray *articles = @[];
                    
                    [obj.articles enumerateObjectsUsingBlock:^(ZDKHelpCenterArticleViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSDictionary *article = @{
                            @"name": obj.name,
                            @"id": obj.id,
                            @"sectionId": obj.section_id,
                        };
                        
                        articles = [articles arrayByAddingObject:article];
                    }];
                    NSDictionary *section = @{
                        @"name": obj.name,
                        @"id": obj.id,
                        @"categoryId": obj.category_id,
                        @"detailTitle": obj.detailTitle,
                        @"articles": articles,
                    };
                    
                    sections = [sections arrayByAddingObject:section];
                }];
                NSDictionary *dic = @{ @"name": obj.name, @"sections": sections };
                result = [result arrayByAddingObject:dic];
            }];
            resolve(result);
        }
    }];
}

// RCT_EXPORT_METHOD(setPrimaryColor:(NSString *)color) {
//     [ZDKCommonTheme currentTheme].primaryColor = [UIColor orangeColor]; // [self colorFromHexString:color];
// }

// - (UIColor *)colorFromHexString:(NSString *)hexString {
//     unsigned rgbValue = 0;
//     NSScanner *scanner = [NSScanner scannerWithString:hexString];
//     [scanner setScanLocation:1];
//     [scanner scanHexInt:&rgbValue];

//     return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
// }

// RCT_EXPORT_METHOD(showHelpCenter:(NSDictionary *)options) {
//   dispatch_sync(dispatch_get_main_queue(), ^{
//     [self showHelpCenterFunction:options];
//   });
// }

//  - (void) showHelpCenterFunction:(NSDictionary *)options {
//      NSError *error = nil;

//      ZDKHelpCenterUiConfiguration* helpCenterUiConfig = [ZDKHelpCenterUiConfiguration new];
//      ZDKArticleUiConfiguration* articleUiConfig = [ZDKArticleUiConfiguration new];
//      if (options[@"disableTicketCreation"]) {
//          helpCenterUiConfig.showContactOptions = NO;
//          articleUiConfig.showContactOptions = NO;
//      }
//      UIViewController* controller = [ZDKHelpCenterUi buildHelpCenterOverviewUiWithConfigs: @[helpCenterUiConfig, articleUiConfig]];
//      // controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Close"
//      //                                                                                    style: UIBarButtonItemStylePlain
//      //                                                                                   target: self
//      //                                                                                   action: @selector(chatClosedClicked)];

//      UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
//      while (topController.presentedViewController) {
//          topController = topController.presentedViewController;
//      }

//      UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController: controller];
//      [topController presentViewController:navControl animated:YES completion:nil];
//  }

@end
