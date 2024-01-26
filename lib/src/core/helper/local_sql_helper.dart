import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

final sqlHelperProvider = Provider<SqlHelper>((ref) {
  return SqlHelper();
});

class SqlHelper {
  Future<void> createTables(sqflite.Database database) async {
    // user data related
    await database.execute("""CREATE TABLE user(
      id TEXT PRIMARY KEY NOT NULL,
      username TEXT,
      email TEXT,
      profile TEXT
    )
    """);

    // all languages related
    await database.execute("""CREATE TABLE languages(
      id TEXT PRIMARY KEY NOT NULL,
      languageName TEXT,
      background TEXT,
      color TEXT,
      textColor TEXT
    )
    """);

    await database.execute("""CREATE TABLE flags(
      id TEXT PRIMARY KEY NOT NULL,
      name TEXT,
      flag_url TEXT,
      lang_id TEXT, 
      FOREIGN KEY (lang_id) REFERENCES languages (id)
    )
    """);

    await database.execute("""CREATE TABLE followings(
      id TEXT PRIMARY KEY NOT NULL,
      uid TEXT,
      languages TEXT,
      languageId TEXT,
      isFollowing INT,
      isSynced INT,
      isDeleted INT,
      FOREIGN KEY (languageId) REFERENCES languages (id)
    )
    """);

    await database.execute("""
  CREATE TABLE version(
    id TEXT PRIMARY KEY NOT NULL DEFAULT '880de450-e904-42d2-9a09-c9d322b9aea7',
    lang_version INT DEFAULT 0,
    type_version INT DEFAULT 0,
    phrase_updated TEXT DEFAULT '50a6fa93-bdd-409a-88f9-73f3f027bd0e_1_1'
  )
""");

    // all types of phrase related

    await database.execute(""" 
  CREATE TABLE top(
    id INT PRIMARY KEY NOT NULL,
    name TEXT,
    color TEXT,
    icon TEXT
  )
    """);

    // all phrases related

    await database.execute(""" 
  CREATE TABLE phrases(
    phraseId INT PRIMARY KEY NOT NULL,
    englishPhrases TEXT,
    translatedPhrases TEXT,
    color TEXT,
    audioLink TEXT,
    langId TEXT,
    typeId INT,
    pronunciation TEXT
  )
    """);
  }

  Future<sqflite.Database> init() async {
    return sqflite.openDatabase(
      'phraso.db',
      version: 1,
      onCreate: (sqflite.Database db, int version) async {
        await createTables(db);
      },
    );
  }
}
