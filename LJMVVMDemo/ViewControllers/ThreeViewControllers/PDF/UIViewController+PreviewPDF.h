//
//  UIViewController+PreviewPDF.h
//  Chuang
//
//  Created by cao longjian on 17/3/11.
//  Copyright © 2017年 JiJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PreviewPDF)<UIDocumentInteractionControllerDelegate>

- (void)showPreviewPDFWithResourcePath:(NSString *)path withExtension:(NSString *)ext;


//- (void)openPDFInMenuWithResourcePath:(NSString *)path withExtension:(NSString *)ext;

@end
