import 'dart:io';
import 'dart:convert';

List<String> checkedLines = [];
List<String> sortedLines = [];
List<String> allProperties = [];
int i = 0;

main() {
  var path = "C:/Users/User/Desktop/Datein/AlphaCSS/bin/samplecss.txt";


  new File(path)
    .openRead()
    .transform(UTF8.decoder)
    .transform(new LineSplitter())
    .forEach((line) => identifyLineType(line)).then(performActionBasedOnType);
}

performActionBasedOnType(thisisnull){
  while (i < checkedLines.length){
    switch(checkedLines[i].substring(0, 5)){
      case "NORM:":
        sortedLines.add(checkedLines[i]);
        break;
      case "PROP:":
        getAllPropertiesInCurrentSelector();
        sortProperties();
        break;
    }
    i++;
  }
  reconstructCSS();
}

void reconstructCSS() {
  String finalCss = "";
  for (var line in sortedLines){
    finalCss += line.substring(5) + "\n";
  }
  print(finalCss);
}

void sortProperties(){
  allProperties.sort();
  for (var property in allProperties){
    sortedLines.add(property);
  }
  allProperties.clear();
}

getAllPropertiesInCurrentSelector() {
  while (checkedLines[i].substring(0, 5) == "PROP:"){
    allProperties.add(checkedLines[i]);
    i++;
  }
  i--;
}

bool isProperty(line) {
  if (line.contains(";")){
    return true;
  }
  return false;
}

void identifyLineType(line){
  if (isProperty(line)){
    checkedLines.add("PROP:$line");
  }
  else {
    checkedLines.add("NORM:$line");
  }
}
