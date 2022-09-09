//  Created by Dominik Hauser on 09.09.22.
//  
//

#import "DDHPlayer.h"

@interface DDHPlayer ()
@property (readwrite) DDHSphereColor color;
@property (nonatomic, readwrite, copy) NSString *name;
@end

@implementation DDHPlayer

- (instancetype)initWithColor:(DDHSphereColor)color {
    if (self = [super init]) {
        _color = color;
    }
    return self;
}

+ (DDHPlayer *)whitePlayer {
    return [self playerForColor:DDHSphereColorWhite];
}

+ (DDHPlayer *)redPlayer {
    return [self playerForColor:DDHSphereColorRed];
}

+ (DDHPlayer *)playerForColor:(DDHSphereColor)color {
    if (color == DDHSphereColorNone) {
        return nil;
    }

    // Color enum is 0/1/2, array is 0/1.
    return [self allPlayers][color - 1];
}

+ (NSArray<DDHPlayer *> *)allPlayers {
    static NSArray<DDHPlayer *> *allPlayers = nil;

    if (allPlayers == nil) {
        allPlayers = @[
            [[DDHPlayer alloc] initWithColor:DDHSphereColorWhite],
            [[DDHPlayer alloc] initWithColor:DDHSphereColorRed],
        ];
    }

    return allPlayers;
}

- (NSString *)name {
    switch (self.color) {
        case DDHSphereColorWhite:
            return @"White";
        case DDHSphereColorRed:
            return @"Red";
        default:
            return nil;
    }
}

- (NSString *)debugDescription {
    switch (self.color) {
        case DDHSphereColorWhite:
            return @"W";
        case DDHSphereColorRed:
            return @"R";
        default:
            return @" ";
    }
}

- (DDHPlayer *)opponent {
    switch (self.color) {
        case DDHSphereColorWhite:
            return [DDHPlayer redPlayer];
        case DDHSphereColorRed:
            return [DDHPlayer whitePlayer];
        default:
            return nil;
    }
}

@end
