//
//  DynamicCell.h
//  DynamicCell
//
//  Created by Anton on 5/29/16.
//  Copyright © 2016 AT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DynamicCell;

@protocol DynamicCellProtocol <NSObject>

- (void)cell:(DynamicCell *)cell changedText:(NSString *)text;

@end

@interface DynamicCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, weak) id<DynamicCellProtocol> delegate;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
