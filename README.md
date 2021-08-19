## vim-borges -- A Plugin of Bifurcating Texts

Hello there person of the internet ;)

This here is a (Barely Functional™) proof-of-concept vim plugin.

It provides a mechanism for specifying and selecting between 
regions of text within a source document.  

Each region can contain a number of possible alternative blocks of text. 

Something like this :=

```txt
Some text: <|
  @1{ foo }
  @2{ bar }
|>
```

Currently the plugin provides 2 functions ( and corresponding shortcuts )

```txt
  borges#bifurcate(lvl) " this will filter a region at the cursor 
  borges#idio(lvl)      " this will filter all regions within the buffer
```
NB., `lvl` defaults to: `\d\+`
and can be controlled with the global variable: `g:borges_currView`

If you ran either function on the example file above, you
should get the following text as a result:

```txt
Some text: foo
```

If you should ensure `lvl == 2` at the time of calling either function
you should get the following text as a result:

```txt
Some text: bar 
```

