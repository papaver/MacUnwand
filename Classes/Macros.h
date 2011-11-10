//
//  Macros.h
//  IPlus
//
//  Created by Moiz Merchant on 9/27/11.
//  Copyright 2011 Bunnies on Acid. All rights reserved.
//

//------------------------------------------------------------------------------
// defines 
//------------------------------------------------------------------------------

#define $string(...) [NSString stringWithFormat:__VA_ARGS__]
#define $array(...)  [NSArray arrayWithObjects:__VA_ARGS__]
#define $dict(k, v)  [NSDictionary dictionaryWithObjects:v forKeys:k]

