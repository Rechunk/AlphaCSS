import 'dart:io';
import "dart:core";

class Token {
  String identifier;
  String value;
  Token(this.identifier, this.value);
}

List<Token> tokens = [];
int i = 0;

void main() {
  String rootPath = "C:/Users/User/Desktop/Datein/AlphaCSS/bin/";
  String originalFilePath = "samplecss.css";

  new File(rootPath + originalFilePath).readAsString().then((String file) {
    List<Token> tokens = getTokensFromFile(file);
    List<Token> sortedTokens = getSortedTokens(tokens);
    new File(rootPath + "newcss.txt").writeAsStringSync(reconstructCSS(sortedTokens));
  });
}

List<Token> getTokensFromFile(file){
  String value = "";
  while (i < file.length-1){
    value = "";
    if (isValidSelector(file[i])){
      value = getTokenContent(file);
      addTokenBasedOnType(file[i], value);
    }
    i++;
  }
  return tokens;
}

bool isValidSelector(String char){
  RegExp regex = new RegExp(r"[a-zA-Z0-9#.]");
  return (regex.hasMatch(char)) ? true : false;
}

String getTokenContent(String file){
  String content = "";
  while (file[i] != "{" && file[i] != ";"){
    content += file[i];
    i++;
  }
  return content;
}

void addTokenBasedOnType(String char, String value){
  if (char == "{"){
    tokens.add(new Token("SELECTOR", value));
  }
  else {
    tokens.add(new Token("PROPERTY", value));
  }
}

int iSort = 0;

List<Token> getSortedTokens(tokens){
  List<Token> sortedTokens = [];
  try {
    while (iSort < tokens.length-1){
      if (tokens[iSort].identifier == "PROPERTY"){
        List<Token> toSort = getAllPropertiesInSelector();
        iSort--;
        toSort.sort((current, next) => current.value.compareTo(next.value));
        for (var elem in toSort){
          sortedTokens.add(elem);
        }
      }
      else if (tokens[iSort].identifier == "SELECTOR"){
        sortedTokens.add(tokens[iSort]);
      }
      iSort++;
    }
  }
  catch(ex) { }
  return sortedTokens;
}

List<Token> getAllPropertiesInSelector(){
  List<Token> properties = [];
  try {
    while (tokens[iSort].identifier == "PROPERTY"){
      properties.add(tokens[iSort]);
      iSort++;
    }
  }
  catch(ex) { };
  return properties;
}

String reconstructCSS(List<Token> sortedTokens) {
  String finalString = "";

  for (var elem in sortedTokens){
    if (elem.identifier == "SELECTOR"){
      finalString += "${elem.value}{\n";
    }
    else if (elem.identifier == "PROPERTY"){
      finalString += "  ${elem.value};\n";
    }
  }
  return finalString;
}
