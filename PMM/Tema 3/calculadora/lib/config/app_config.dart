List<String> firstRow = ['7', '8', '9', '+'];
List<String> secondRow = ['4', '5', '6', '-'];
List<String> thirdRow = ['1', '2', '3', '*'];
List<String> forthRow = ['0', 'C', '=', '/'];

Map<String, String> modes = {
  "+": "SUM",
  "-": "MINUS",
  "*": "MULTIPLY",
  "/": "DIVIDE"
};

Map<String, String> specialButtonsConfig = {"=": "EQUAL", "C": "ERASE_ALL"};
