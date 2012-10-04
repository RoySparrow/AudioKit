//
//  OCSOscillator.m
//  Objective-C Sound
//
//  Created by Aurelius Prochazka on 4/13/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "OCSOscillator.h"

@interface OCSOscillator () {
    OCSParameter *amp;
    OCSParameter *freq;
    OCSConstant *phs;
    OCSFTable *f;
    
    
    OCSParameter *audio;
    OCSControl *control;
    OCSParameter *output;
}
@end

@implementation OCSOscillator 

@synthesize audio;
@synthesize control;
@synthesize output;

- (id)initWithFTable:(OCSFTable *)fTable
               phase:(OCSConstant *)initialPhase
           frequency:(OCSParameter *)frequency
           amplitude:(OCSParameter *)amplitude;
{
    self = [super init];
    if (self) {
        audio   = [OCSParameter parameterWithString:[self operationName]];
        control = [OCSControl parameterWithString:[self operationName]];
        output  =  audio;
        amp  = amplitude;
        freq = frequency;
        f    = fTable;
        phs  = initialPhase;
    }
    return self; 
}

- (id)initWithFTable:(OCSFTable *)fTable
           frequency:(OCSParameter *)frequency
           amplitude:(OCSParameter *)amplitude;
{
    return [self initWithFTable:fTable
                          phase:[OCSConstant parameterWithInt:0]
                      frequency:frequency
                      amplitude:amplitude];
}

- (void)setControl:(OCSControl *)p {
    control = p;
    output = control;
}

- (NSString *)stringForCSD {
    return [NSString stringWithFormat: 
            @"%@ oscili %@, %@, %@, %@", 
            output, amp, freq, f, phs];
}

- (NSString *)description {
    return [output parameterString];
}



@end
