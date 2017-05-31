# AlphaCSS
A small tool to refactor your css files. Currently, it reformats your code and orders your properties alphabetically.

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
