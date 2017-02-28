/*
 *  DisclosureView.m
 *  Vienna
 *
 *
 *  Copyright 2017
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  https://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#import "DisclosureView.h"

@interface DisclosureView()

@property (readonly, nonatomic) CGFloat disclosedViewHeight;
@property (nonatomic) NSLayoutConstraint *heightConstraint;

@end

@implementation DisclosureView

#pragma mark Accessors

- (BOOL)isDisclosed {
    return self.frame.size.height > 0;
}

- (CGFloat)disclosedViewHeight {
    return self.disclosedView.frame.size.height;
}

- (NSLayoutConstraint *)heightConstraint {
    if (!_heightConstraint) {
        _heightConstraint = [NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1
                                                          constant:self.disclosedViewHeight];
    }
    return _heightConstraint;
}

#pragma mark Methods

- (void)collapse:(BOOL)animate {
    [self addConstraint:self.heightConstraint];
    if (animate) {
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            self.heightConstraint.animator.constant = 0;
        } completionHandler:^{
            self.disclosedView.hidden = YES;
        }];
    } else {
        self.heightConstraint.constant = 0;
        self.disclosedView.hidden = YES;
    }
}

- (void)disclose:(BOOL)animate {
    self.disclosedView.hidden = NO;
    if (animate) {
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            self.heightConstraint.animator.constant = self.disclosedViewHeight;
        } completionHandler:^{
            [self removeConstraint:self.heightConstraint];
        }];
    } else {
        self.heightConstraint.constant = self.disclosedViewHeight;
        [self removeConstraint:self.heightConstraint];
    }
}

@end
