# AlphaCSS
A small tool to refactor your css files. Currently, it reformats your code and orders your properties alphabetically.

Warning: not meant for development use, as through changing the order of the properties the visuals could be affected

To be added:

 - Dynamic file options (IO)
 - Minification
 - Dead Code removal
 
Bugs to fix:

  - Preserve order if a shorthand property is combined with the written out version

### Turn:

```
h1{z-index: 4; color:red; }
```

### Into:

```
h1 {
  color: red;
  z-index: 4;
}
```
