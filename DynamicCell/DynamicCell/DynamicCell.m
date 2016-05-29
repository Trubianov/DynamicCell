//
//  DynamicCell.m
//  DynamicCell
//
//  Created by Anton on 5/29/16.
//  Copyright © 2016 AT. All rights reserved.
//

#import "DynamicCell.h"

@implementation DynamicCell


#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self.delegate cell:self changedText:[textView.attributedText string]];
}



@end
