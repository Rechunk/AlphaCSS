import 'dart:io';
import "dart:core";

class Token {
  String identifier;
  String value;
  Token(this.identifier, this.value);
}

int i = 0;

void main() {
  var path = "C:/Users/User/Desktop/Datein/AlphaCSS/bin/samplecss.txt";

  new File(path).readAsString().then((String file) {
    List<Token> tokens = getTokensFromFile(file);
    List<Token> sortedTokens = getSortedTokens(tokens);
    for (var x in sortedTokens){
      print("${x.identifier} ${x.value}");
    }
  });
}

bool isValidAccessor(String char){
  RegExp regex = new RegExp(r"[a-zA-Z0-9#.]");
  return (regex.hasMatch(char)) ? true : false;
}

List<Token> getTokensFromFile(file){
  List<Token> tokens = [];
  String value = "";
  while (i < file.length-1){
    value = "";
    if (isValidAccessor(file[i])){
      while (file[i] != "{" && file[i] != ";"){
        value += file[i];
        i++;
      }
      if (file[i] == "{"){
        tokens.add(new Token("ACCESSOR", value));
      }
      else {
        tokens.add(new Token("PROPERTY", value));
      }
    }
    i++;
  }
  return tokens;
}

void reconstructCSS() {

}

List<Token> getSortedTokens(tokens){
  List<Token> sortedTokens = [];
  i = 0;
  try {
    while (i < tokens.length-1){
      if (tokens[i].identifier == "PROPERTY"){
        List<Token> toSort = [];
        while (tokens[i].identifier == "PROPERTY"){
          toSort.add(tokens[i]);
          i++;
        }
        toSort.sort((current, next) => current.value.compareTo(next.value));
        for (var elem in toSort){
          sortedTokens.add(elem);
        }
      }
      else if (tokens[i].identifier == "ACCESSOR"){
        sortedTokens.add(tokens[i]);
      }
      i++;
    }
  }
  catch(ex) {}
  return sortedTokens;
}
