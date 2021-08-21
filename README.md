## vim-borges -- A Plugin of Bifurcating Texts

Hello there person of the internet ;)

This here is a (Barely Functional™) proof-of-concept vim plugin.

It provides a mechanism for specifying and selecting between 
regions of text within a source document.  

Each region can contain a number of possible alternative blocks of text. 

Currently the plugin provides 2 functions ( and corresponding commands + shortcuts )

```
  borges#bifurcate(lvl) " this will filter a region at the cursor 
  borges#idio(lvl)      " this will filter all regions within the buffer
  
  IdioSync call borges#idio(<f-args>)
  <C-F> :IdioSync 

  Bifurcate call borges#bifurcate(<f-args>)
  <C-D> :Bifurcate 
```

NB., `lvl` defaults to: `\d\+`
and can be controlled with the global variable: `g:borges_currView`

If you run either function on the example below...

```txt
Some text: <|
  @1{ foo }
  @2{ bar }
|>
```

you should get the following text as a result:

```txt
Some text: foo
```

If you should ensure `lvl == 2` at the time of calling either function
you should get the following text as a result:

```txt
Some text: bar 
```

Install like so :=

```
  cd /path/to/preferred/location
  git clone https://github.com/joe-opensrc/vim-borges.git
  cd ~/.vim/plugins/joe-opensrc/start
  ln -s /path/to/preferred/location/vim-borges borges 
```

TODO:
```
  - find a way of handling spaces / column offsets in an intelligent manner...
    perhaps with different notation, e.g., '%1{ }'
  - look to making it memory sensible...streaming from top of file
  - maybe try and get it working again with functions and not norm gestures...
  - maybe look to using quickfix/loclist 
  - make copy of current buffer and work on that 

```
