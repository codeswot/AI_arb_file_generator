import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

part 'database.g.dart';

@DriftDatabase(include: {'tables.drift'})
class Database extends _$Database {
  // we tell the database where to store the data with this constructor
  Database(Function opener) : super(opener());
  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  int now() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}

LazyDatabase _openLocalConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    final workDir = Directory.current.path;

    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final file = File(p.join(workDir, 'assets', 'db.sqlite'));

    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}

final dbProviderLocal = Provider<Database>((ref) {
  return Database(_openLocalConnection);
});
