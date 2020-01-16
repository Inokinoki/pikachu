# Pikachu

A programming language of the most cute pokemon based on Brainfuck.

## Introduction

Brainfuck is an esoteric programming language created in 1993 by Urban Müller, and is notable for its extreme minimalism.

For more information on it or some tutorials, please go to [Wikipedia](https://en.wikipedia.org/wiki/Brainfuck).

Here, I assume that you've mastered Brainfuck.

The pikachu programming language is just a simple variation of it:
- `pi` replaces `<`
- `ka` replaces `+`
- `chu` replaces `>`

So, as the Brainfuck language, in theory, you can write any program with it:)

But for the implementation, the "memory" is limited by 300000.

Just4fun, it's enough!

## Use

Make sure you have `flex`+`bison`/`lex`+`yacc` installed.

1. Generate token parser code with lex:

```bash
lex pikachu.l
```

You'll get `lex.yy.c`.

2. Generate grammar parser code with yacc:

```bash
yacc -d pikachu.y
```

You'll get `y.tab.c` and `y.tab.h`.

3. Compile:

```bash
gcc y.tab.c lex.yy.c -ly -o pikachu
```

4. Test:

```bash
./pikachu < test-helloworld.txt
```

You should get the output `Hello World!`.

## Code

Code your program on Brainfuck, transform `<` with `pi`, `>` with `chu`, `+` with `ka`, and keep the other characters not changed.

Then you master the programming language `pikachu`.
