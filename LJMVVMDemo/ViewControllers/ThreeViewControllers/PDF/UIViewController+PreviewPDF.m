//
//  UIViewController+PreviewPDF.m
//  Chuang
//
//  Created by cao longjian on 17/3/11.
//  Copyright © 2017年 JiJi. All rights reserved.
//

#import "UIViewController+PreviewPDF.h"


@implementation UIViewController (PreviewPDF)

- (void)showPreviewPDFWithResourcePath:(NSString *)path withExtension:(NSString *)ext{
    NSURL *URL = [[NSBundle mainBundle] URLForResource:path withExtension:ext];
    
    if (URL) {
        // Initialize Document Interaction Controller
        UIDocumentInteractionController *documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        [documentInteractionController setDelegate:self];
        
        [documentInteractionController presentPreviewAnimated:YES];
    }
}

- (void)openPDFInMenuWithResourcePath:(NSString *)path withExtension:(NSString *)ext{
    NSURL *URL = [[NSBundle mainBundle] URLForResource:path withExtension:ext];
    if (URL) {
        // Initialize Document Interaction Controller
        UIDocumentInteractionController *documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        
        [documentInteractionController setDelegate:self];
        
//        [documentInteractionController presentOpenInMenuFromRect:[button frame] inView:self.view animated:YES];
    }
}

#pragma mark Document Interaction Controller Delegate Methods
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

@end
