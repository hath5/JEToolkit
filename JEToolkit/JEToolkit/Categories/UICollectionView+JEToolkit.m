//
//  UICollectionView+JEToolkit.m
//  JEToolkit
//
//  Copyright (c) 2014 John Rommel Estropia
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "UICollectionView+JEToolkit.h"

#import "NSObject+JEToolkit.h"
#import "UINib+JEToolkit.h"

#if __has_include("JEDebugging.h")
#import "JEDebugging.h"
#else
#define JEAssertParameter   NSCParameterAssert
#endif


@implementation UICollectionView (JEToolkit)

- (void)registerCollectionViewCellClass:(Class)collectionViewCellClass {
    
    [self registerCollectionViewCellClass:collectionViewCellClass subIdentifier:nil];
}

- (void)registerCollectionViewCellClass:(Class)collectionViewCellClass
                          subIdentifier:(NSString *)subIdentifier {
    
    JEAssertParameter([collectionViewCellClass isSubclassOfClass:[UICollectionViewCell class]]);
    
    NSString *className = [collectionViewCellClass className];
    NSString *reuseIdentifier = className;
    if (subIdentifier) {
        
        reuseIdentifier = [className stringByAppendingString:subIdentifier];
    }
    if ([UINib nibWithNameExists:className]) {
        
        [self
         registerNib:[UINib cachedNibWithName:className]
         forCellWithReuseIdentifier:reuseIdentifier];
    }
    else {
        
        [self
         registerClass:collectionViewCellClass
         forCellWithReuseIdentifier:reuseIdentifier];
    }
}

- (id)dequeueReusableCellWithClass:(Class)collectionViewCellClass
                      forIndexPath:(NSIndexPath *)indexPath {
    
    return [self
            dequeueReusableCellWithClass:collectionViewCellClass
            subIdentifier:nil
            forIndexPath:indexPath];
}

- (id)dequeueReusableCellWithClass:(Class)collectionViewCellClass
                     subIdentifier:(NSString *)subIdentifier
                      forIndexPath:(NSIndexPath *)indexPath {
    
    JEAssertParameter([collectionViewCellClass isSubclassOfClass:[UICollectionViewCell class]]);
    JEAssertParameter(indexPath != nil);
    
    NSString *className = [collectionViewCellClass className];
    NSString *reuseIdentifier = className;
    if (subIdentifier) {
        
        reuseIdentifier = [className stringByAppendingString:subIdentifier];
    }
    id cell = [self
               dequeueReusableCellWithReuseIdentifier:reuseIdentifier
               forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[collectionViewCellClass alloc] initWithFrame:CGRectZero];
    }
    
    return cell;
}

@end
