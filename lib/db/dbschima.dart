class TableNAME {
  static String tableName = 'notes';
}

class NotefIelds {
  static String id = '_id';
  static String title = 'title';
  static String isImportent = "isImportent";
  static String descp = "description";
  static String number = "number";
  static String createdTime = 'time';
  static String slctDelete = "slctDelete";

  static final List<String> columns = [
    id,
    title,
    isImportent,
    descp,
    number,
    slctDelete,
    createdTime
  ];
  static String orderBY = "$createdTime ASC";
}

class NotefIeldsTypes {
  static String id = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static String? title = 'TEXT NOT NULL';
  static String? isImportent = 'BOOLEAN NOT NULL';
  static String? descp = "TEXT NOT NULL";
  static String? number = "INTEGER NOT NULL";
  static String? createdTime = 'TEXT NOT NULL';
}
