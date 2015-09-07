//
//  CalculatorBrain.m
//  Calculator
//
//  Created by cipher on 15/8/27.
//  Copyright (c) 2015年 com.lab1411.cipher. All rights reserved.
//

#import "CalculatorBrain.h"

//private
@interface CalculatorBrain()

//初始化为nil或0
@property(nonatomic,strong) NSMutableArray *programStack;

@end



@implementation CalculatorBrain

@synthesize programStack = _programStack;
//只有一个变量指针 不分配内存空间

//warning
//这里很重要 刚开始没有更改为programStack，则一直没有初始化
//导致后面的数据 一直加入不到栈中
-(NSMutableArray *)programStack{
    
    //延迟实例化
    if(_programStack == nil){
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

-(void)setOperandStack:(NSMutableArray *)operandStack{
    _programStack = operandStack;
}

//入操作数
-(void)pushOperation:(double) operand{
    //add只能加入对象
    
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];

}

-(id)program{
    
    return [self.programStack copy];
}

+(NSString *)descriptionOfProgram:(id)program{
    return @"implement this in Assignment 2";
}

+(double)popOperandOfStack:(NSMutableArray *)stack{
    

    double result = 0;
    id topOfStack = [stack lastObject];
    
    if (topOfStack) {
        [stack removeLastObject];
    }
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
        
    }else if([topOfStack isKindOfClass:[NSString class]]){
        
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result =[self popOperandOfStack:stack] + [self popOperandOfStack:stack];
        }else if ([operation isEqualToString:@"/"]){
            
            double tmp2 = [self popOperandOfStack:stack];
            double tmp1 = [self popOperandOfStack:stack];
            if (tmp2 != 0) {
                result = tmp1 / tmp2;
            }
        }else if([operation isEqualToString:@"*"]){
            result = [self popOperandOfStack:stack] * [self popOperandOfStack:stack];
        }else if([operation isEqualToString:@"-"]){
            double tmp2 = [self popOperandOfStack:stack];
            double tmp1 = [self popOperandOfStack:stack];
            result = tmp1 - tmp2;
        }
    }
    return result;
}

+(double)runProgram:(id)program{
    
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOfStack:stack];
}


-(double)performOperation:(NSString *)operation{
    
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}



@end
