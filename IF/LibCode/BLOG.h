//
//  BLOG.h
//  IF
//
//  Created by Daren taylor on 16/04/2014.
//  Copyright (c) 2014 DDT. All rights reserved.
//

#ifndef IF_BLOG_h
#define IF_BLOG_h

/*
 
I started developing 'apps' or programs as we called them back in the day since 1981, we were the first people that I kew to have a home computer, id known a guy at school with a zx81 just before us, I was jellous at the time but my real computer made up for it, with its 3.5k of ram, C2N tape drive (the bar of soap) an introduction to basic, with its fow chart template and the introduction cassete with Race, Hoppit, Type a Tune and Blitz I didnt need the outdoors any longer.
 For the first few days my sister had a look through the programming stuff while I played games I was encouraged by my parents to do some 'education stuff' but I reall was far more keen to play Blitz, my mum also got obsessed by that game.
 Once they had got bored themselves and I was bored of the games, my journey did commence.
 I recall making the bird fly with the Petscii graphics, they were the special predefined graphic characters that were mapped onto the front of each key.
 It wasnt long before I was making my first BASIC programs, but one day I was reading in a magazine (INPUT I think) about this thing called MACHINE CODE, this was it, this was the real language.
 Im no genius, but I picked up this crazy RISC like implementation relativly easily, the processor the 6502 was made for humans to write code on, todays processors are made for compilers to write code, and have many abstract concepts that dont really apply to coding business logic.
 I taught both of my kids to encode and decode binary at the age of 5 or 6 and they could also convert to and from decimal and hex, kids actually like the little formulas which are almost like little games to them
 For a long time ive wished that there was a simple language like 6502 on the iPhone and the Mac, somethign where ill be able to teach the kids the logic of coding with none of the hassle of a language like objective C, which is just too much for a kid to take in.
 So ive been thinking......
 A language where 
 
 All but the absolute neccessary is removed.
 The labguage must have a 'feel' about it, maybe like a machine language, setting flags and addressses
 MACROS can be used to build up functionality to encourage code reuse.
 
 At this point ive got the language down to a handful of commands, here is an example program
 
 SET 54
 WRITE 100
 SET 20
 WRITE 101
 OUT
 Loop:
 READ 100
 OUT
 INC 1
 WRITE 100
 DEC 60
 IF Loop
 READ 101
 OUT
 
 Im going to call the language IF
 
 
 In DDT I didnt plan properly, in fact I didnt want to ask the game was designed as I went along, this is a hobby after all, and its a game. But for IF the development process can be made more efficient by using agile, namely storycards and TODO, In Progress and Complete sections, I generally use Trello for this, as its really simple and has good support for collaboration.
 
 ScreenShot trello cards
 
 
 
 
 */

#endif
