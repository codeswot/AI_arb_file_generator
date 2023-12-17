// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class GlobalLanguages extends Table
    with TableInfo<GlobalLanguages, GlobalLanguage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  GlobalLanguages(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  @override
  List<GeneratedColumn> get $columns => [id, language, code];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'globalLanguages';
  @override
  VerificationContext validateIntegrity(Insertable<GlobalLanguage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GlobalLanguage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GlobalLanguage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
    );
  }

  @override
  GlobalLanguages createAlias(String alias) {
    return GlobalLanguages(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class GlobalLanguage extends DataClass implements Insertable<GlobalLanguage> {
  final int? id;
  final String language;
  final String code;
  const GlobalLanguage({this.id, required this.language, required this.code});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['language'] = Variable<String>(language);
    map['code'] = Variable<String>(code);
    return map;
  }

  GlobalLanguagesCompanion toCompanion(bool nullToAbsent) {
    return GlobalLanguagesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      language: Value(language),
      code: Value(code),
    );
  }

  factory GlobalLanguage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GlobalLanguage(
      id: serializer.fromJson<int?>(json['id']),
      language: serializer.fromJson<String>(json['language']),
      code: serializer.fromJson<String>(json['code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'language': serializer.toJson<String>(language),
      'code': serializer.toJson<String>(code),
    };
  }

  GlobalLanguage copyWith(
          {Value<int?> id = const Value.absent(),
          String? language,
          String? code}) =>
      GlobalLanguage(
        id: id.present ? id.value : this.id,
        language: language ?? this.language,
        code: code ?? this.code,
      );
  @override
  String toString() {
    return (StringBuffer('GlobalLanguage(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language, code);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlobalLanguage &&
          other.id == this.id &&
          other.language == this.language &&
          other.code == this.code);
}

class GlobalLanguagesCompanion extends UpdateCompanion<GlobalLanguage> {
  final Value<int?> id;
  final Value<String> language;
  final Value<String> code;
  const GlobalLanguagesCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.code = const Value.absent(),
  });
  GlobalLanguagesCompanion.insert({
    this.id = const Value.absent(),
    required String language,
    required String code,
  })  : language = Value(language),
        code = Value(code);
  static Insertable<GlobalLanguage> custom({
    Expression<int>? id,
    Expression<String>? language,
    Expression<String>? code,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (code != null) 'code': code,
    });
  }

  GlobalLanguagesCompanion copyWith(
      {Value<int?>? id, Value<String>? language, Value<String>? code}) {
    return GlobalLanguagesCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      code: code ?? this.code,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GlobalLanguagesCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }
}

class Apps extends Table with TableInfo<Apps, App> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Apps(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'DEFAULT 1',
      defaultValue: const CustomExpression('1'));
  static const VerificationMeta _appGeneratedMeta =
      const VerificationMeta('appGenerated');
  late final GeneratedColumn<int> appGenerated = GeneratedColumn<int>(
      'app_generated', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  @override
  List<GeneratedColumn> get $columns => [id, name, version, appGenerated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apps';
  @override
  VerificationContext validateIntegrity(Insertable<App> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    }
    if (data.containsKey('app_generated')) {
      context.handle(
          _appGeneratedMeta,
          appGenerated.isAcceptableOrUnknown(
              data['app_generated']!, _appGeneratedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  App map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return App(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version']),
      appGenerated: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}app_generated']),
    );
  }

  @override
  Apps createAlias(String alias) {
    return Apps(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class App extends DataClass implements Insertable<App> {
  final int? id;
  final String name;
  final int? version;
  final int? appGenerated;
  const App({this.id, required this.name, this.version, this.appGenerated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || version != null) {
      map['version'] = Variable<int>(version);
    }
    if (!nullToAbsent || appGenerated != null) {
      map['app_generated'] = Variable<int>(appGenerated);
    }
    return map;
  }

  AppsCompanion toCompanion(bool nullToAbsent) {
    return AppsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      version: version == null && nullToAbsent
          ? const Value.absent()
          : Value(version),
      appGenerated: appGenerated == null && nullToAbsent
          ? const Value.absent()
          : Value(appGenerated),
    );
  }

  factory App.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return App(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      version: serializer.fromJson<int?>(json['version']),
      appGenerated: serializer.fromJson<int?>(json['app_generated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String>(name),
      'version': serializer.toJson<int?>(version),
      'app_generated': serializer.toJson<int?>(appGenerated),
    };
  }

  App copyWith(
          {Value<int?> id = const Value.absent(),
          String? name,
          Value<int?> version = const Value.absent(),
          Value<int?> appGenerated = const Value.absent()}) =>
      App(
        id: id.present ? id.value : this.id,
        name: name ?? this.name,
        version: version.present ? version.value : this.version,
        appGenerated:
            appGenerated.present ? appGenerated.value : this.appGenerated,
      );
  @override
  String toString() {
    return (StringBuffer('App(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('version: $version, ')
          ..write('appGenerated: $appGenerated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, version, appGenerated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is App &&
          other.id == this.id &&
          other.name == this.name &&
          other.version == this.version &&
          other.appGenerated == this.appGenerated);
}

class AppsCompanion extends UpdateCompanion<App> {
  final Value<int?> id;
  final Value<String> name;
  final Value<int?> version;
  final Value<int?> appGenerated;
  const AppsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.version = const Value.absent(),
    this.appGenerated = const Value.absent(),
  });
  AppsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.version = const Value.absent(),
    this.appGenerated = const Value.absent(),
  }) : name = Value(name);
  static Insertable<App> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? version,
    Expression<int>? appGenerated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (version != null) 'version': version,
      if (appGenerated != null) 'app_generated': appGenerated,
    });
  }

  AppsCompanion copyWith(
      {Value<int?>? id,
      Value<String>? name,
      Value<int?>? version,
      Value<int?>? appGenerated}) {
    return AppsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      version: version ?? this.version,
      appGenerated: appGenerated ?? this.appGenerated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (appGenerated.present) {
      map['app_generated'] = Variable<int>(appGenerated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('version: $version, ')
          ..write('appGenerated: $appGenerated')
          ..write(')'))
        .toString();
  }
}

class AppLanguages extends Table with TableInfo<AppLanguages, AppLanguage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AppLanguages(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _appNameMeta =
      const VerificationMeta('appName');
  late final GeneratedColumn<String> appName = GeneratedColumn<String>(
      'app_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES apps(name)');
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL UNIQUE REFERENCES globalLanguages(language)');
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE REFERENCES globalLanguages(code)');
  @override
  List<GeneratedColumn> get $columns => [id, appName, language, languageCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appLanguages';
  @override
  VerificationContext validateIntegrity(Insertable<AppLanguage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('app_name')) {
      context.handle(_appNameMeta,
          appName.isAcceptableOrUnknown(data['app_name']!, _appNameMeta));
    } else if (isInserting) {
      context.missing(_appNameMeta);
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppLanguage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppLanguage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      appName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_name'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
    );
  }

  @override
  AppLanguages createAlias(String alias) {
    return AppLanguages(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class AppLanguage extends DataClass implements Insertable<AppLanguage> {
  final int? id;
  final String appName;
  final String language;
  final String languageCode;
  const AppLanguage(
      {this.id,
      required this.appName,
      required this.language,
      required this.languageCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['app_name'] = Variable<String>(appName);
    map['language'] = Variable<String>(language);
    map['language_code'] = Variable<String>(languageCode);
    return map;
  }

  AppLanguagesCompanion toCompanion(bool nullToAbsent) {
    return AppLanguagesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      appName: Value(appName),
      language: Value(language),
      languageCode: Value(languageCode),
    );
  }

  factory AppLanguage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppLanguage(
      id: serializer.fromJson<int?>(json['id']),
      appName: serializer.fromJson<String>(json['app_name']),
      language: serializer.fromJson<String>(json['language']),
      languageCode: serializer.fromJson<String>(json['language_code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'app_name': serializer.toJson<String>(appName),
      'language': serializer.toJson<String>(language),
      'language_code': serializer.toJson<String>(languageCode),
    };
  }

  AppLanguage copyWith(
          {Value<int?> id = const Value.absent(),
          String? appName,
          String? language,
          String? languageCode}) =>
      AppLanguage(
        id: id.present ? id.value : this.id,
        appName: appName ?? this.appName,
        language: language ?? this.language,
        languageCode: languageCode ?? this.languageCode,
      );
  @override
  String toString() {
    return (StringBuffer('AppLanguage(')
          ..write('id: $id, ')
          ..write('appName: $appName, ')
          ..write('language: $language, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, appName, language, languageCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLanguage &&
          other.id == this.id &&
          other.appName == this.appName &&
          other.language == this.language &&
          other.languageCode == this.languageCode);
}

class AppLanguagesCompanion extends UpdateCompanion<AppLanguage> {
  final Value<int?> id;
  final Value<String> appName;
  final Value<String> language;
  final Value<String> languageCode;
  const AppLanguagesCompanion({
    this.id = const Value.absent(),
    this.appName = const Value.absent(),
    this.language = const Value.absent(),
    this.languageCode = const Value.absent(),
  });
  AppLanguagesCompanion.insert({
    this.id = const Value.absent(),
    required String appName,
    required String language,
    required String languageCode,
  })  : appName = Value(appName),
        language = Value(language),
        languageCode = Value(languageCode);
  static Insertable<AppLanguage> custom({
    Expression<int>? id,
    Expression<String>? appName,
    Expression<String>? language,
    Expression<String>? languageCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (appName != null) 'app_name': appName,
      if (language != null) 'language': language,
      if (languageCode != null) 'language_code': languageCode,
    });
  }

  AppLanguagesCompanion copyWith(
      {Value<int?>? id,
      Value<String>? appName,
      Value<String>? language,
      Value<String>? languageCode}) {
    return AppLanguagesCompanion(
      id: id ?? this.id,
      appName: appName ?? this.appName,
      language: language ?? this.language,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (appName.present) {
      map['app_name'] = Variable<String>(appName.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppLanguagesCompanion(')
          ..write('id: $id, ')
          ..write('appName: $appName, ')
          ..write('language: $language, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }
}

class Entries extends Table with TableInfo<Entries, SentenceEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Entries(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _appNameMeta =
      const VerificationMeta('appName');
  late final GeneratedColumn<String> appName = GeneratedColumn<String>(
      'app_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES apps(name)');
  static const VerificationMeta _entryIdMeta =
      const VerificationMeta('entryId');
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
      'entry_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  static const VerificationMeta _entryKeyMeta =
      const VerificationMeta('entryKey');
  late final GeneratedColumn<String> entryKey = GeneratedColumn<String>(
      'entry_key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _entryTranslationFromMeta =
      const VerificationMeta('entryTranslationFrom');
  late final GeneratedColumn<String> entryTranslationFrom =
      GeneratedColumn<String>('entry_translation_from', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  static const VerificationMeta _entryTranslationToMeta =
      const VerificationMeta('entryTranslationTo');
  late final GeneratedColumn<String> entryTranslationTo =
      GeneratedColumn<String>('entry_translation_to', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _entryLanguageFromMeta =
      const VerificationMeta('entryLanguageFrom');
  late final GeneratedColumn<String> entryLanguageFrom =
      GeneratedColumn<String>('entry_language_from', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL REFERENCES appLanguages(language)');
  static const VerificationMeta _entryLanguageToMeta =
      const VerificationMeta('entryLanguageTo');
  late final GeneratedColumn<String> entryLanguageTo = GeneratedColumn<String>(
      'entry_language_to', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES appLanguages(language)');
  static const VerificationMeta _entryGeneratedMeta =
      const VerificationMeta('entryGenerated');
  late final GeneratedColumn<int> entryGenerated = GeneratedColumn<int>(
      'entry_generated', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        appName,
        entryId,
        entryKey,
        entryTranslationFrom,
        entryTranslationTo,
        entryLanguageFrom,
        entryLanguageTo,
        entryGenerated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries';
  @override
  VerificationContext validateIntegrity(Insertable<SentenceEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('app_name')) {
      context.handle(_appNameMeta,
          appName.isAcceptableOrUnknown(data['app_name']!, _appNameMeta));
    } else if (isInserting) {
      context.missing(_appNameMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('entry_key')) {
      context.handle(_entryKeyMeta,
          entryKey.isAcceptableOrUnknown(data['entry_key']!, _entryKeyMeta));
    } else if (isInserting) {
      context.missing(_entryKeyMeta);
    }
    if (data.containsKey('entry_translation_from')) {
      context.handle(
          _entryTranslationFromMeta,
          entryTranslationFrom.isAcceptableOrUnknown(
              data['entry_translation_from']!, _entryTranslationFromMeta));
    } else if (isInserting) {
      context.missing(_entryTranslationFromMeta);
    }
    if (data.containsKey('entry_translation_to')) {
      context.handle(
          _entryTranslationToMeta,
          entryTranslationTo.isAcceptableOrUnknown(
              data['entry_translation_to']!, _entryTranslationToMeta));
    }
    if (data.containsKey('entry_language_from')) {
      context.handle(
          _entryLanguageFromMeta,
          entryLanguageFrom.isAcceptableOrUnknown(
              data['entry_language_from']!, _entryLanguageFromMeta));
    } else if (isInserting) {
      context.missing(_entryLanguageFromMeta);
    }
    if (data.containsKey('entry_language_to')) {
      context.handle(
          _entryLanguageToMeta,
          entryLanguageTo.isAcceptableOrUnknown(
              data['entry_language_to']!, _entryLanguageToMeta));
    } else if (isInserting) {
      context.missing(_entryLanguageToMeta);
    }
    if (data.containsKey('entry_generated')) {
      context.handle(
          _entryGeneratedMeta,
          entryGenerated.isAcceptableOrUnknown(
              data['entry_generated']!, _entryGeneratedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SentenceEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SentenceEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      appName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_name'])!,
      entryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entry_id'])!,
      entryKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entry_key'])!,
      entryTranslationFrom: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}entry_translation_from'])!,
      entryTranslationTo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}entry_translation_to']),
      entryLanguageFrom: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}entry_language_from'])!,
      entryLanguageTo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}entry_language_to'])!,
      entryGenerated: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}entry_generated']),
    );
  }

  @override
  Entries createAlias(String alias) {
    return Entries(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class SentenceEntry extends DataClass implements Insertable<SentenceEntry> {
  final int? id;
  final String appName;
  final String entryId;
  final String entryKey;
  final String entryTranslationFrom;
  final String? entryTranslationTo;
  final String entryLanguageFrom;
  final String entryLanguageTo;
  final int? entryGenerated;
  const SentenceEntry(
      {this.id,
      required this.appName,
      required this.entryId,
      required this.entryKey,
      required this.entryTranslationFrom,
      this.entryTranslationTo,
      required this.entryLanguageFrom,
      required this.entryLanguageTo,
      this.entryGenerated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['app_name'] = Variable<String>(appName);
    map['entry_id'] = Variable<String>(entryId);
    map['entry_key'] = Variable<String>(entryKey);
    map['entry_translation_from'] = Variable<String>(entryTranslationFrom);
    if (!nullToAbsent || entryTranslationTo != null) {
      map['entry_translation_to'] = Variable<String>(entryTranslationTo);
    }
    map['entry_language_from'] = Variable<String>(entryLanguageFrom);
    map['entry_language_to'] = Variable<String>(entryLanguageTo);
    if (!nullToAbsent || entryGenerated != null) {
      map['entry_generated'] = Variable<int>(entryGenerated);
    }
    return map;
  }

  EntriesCompanion toCompanion(bool nullToAbsent) {
    return EntriesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      appName: Value(appName),
      entryId: Value(entryId),
      entryKey: Value(entryKey),
      entryTranslationFrom: Value(entryTranslationFrom),
      entryTranslationTo: entryTranslationTo == null && nullToAbsent
          ? const Value.absent()
          : Value(entryTranslationTo),
      entryLanguageFrom: Value(entryLanguageFrom),
      entryLanguageTo: Value(entryLanguageTo),
      entryGenerated: entryGenerated == null && nullToAbsent
          ? const Value.absent()
          : Value(entryGenerated),
    );
  }

  factory SentenceEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SentenceEntry(
      id: serializer.fromJson<int?>(json['id']),
      appName: serializer.fromJson<String>(json['app_name']),
      entryId: serializer.fromJson<String>(json['entry_id']),
      entryKey: serializer.fromJson<String>(json['entry_key']),
      entryTranslationFrom:
          serializer.fromJson<String>(json['entry_translation_from']),
      entryTranslationTo:
          serializer.fromJson<String?>(json['entry_translation_to']),
      entryLanguageFrom:
          serializer.fromJson<String>(json['entry_language_from']),
      entryLanguageTo: serializer.fromJson<String>(json['entry_language_to']),
      entryGenerated: serializer.fromJson<int?>(json['entry_generated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'app_name': serializer.toJson<String>(appName),
      'entry_id': serializer.toJson<String>(entryId),
      'entry_key': serializer.toJson<String>(entryKey),
      'entry_translation_from': serializer.toJson<String>(entryTranslationFrom),
      'entry_translation_to': serializer.toJson<String?>(entryTranslationTo),
      'entry_language_from': serializer.toJson<String>(entryLanguageFrom),
      'entry_language_to': serializer.toJson<String>(entryLanguageTo),
      'entry_generated': serializer.toJson<int?>(entryGenerated),
    };
  }

  SentenceEntry copyWith(
          {Value<int?> id = const Value.absent(),
          String? appName,
          String? entryId,
          String? entryKey,
          String? entryTranslationFrom,
          Value<String?> entryTranslationTo = const Value.absent(),
          String? entryLanguageFrom,
          String? entryLanguageTo,
          Value<int?> entryGenerated = const Value.absent()}) =>
      SentenceEntry(
        id: id.present ? id.value : this.id,
        appName: appName ?? this.appName,
        entryId: entryId ?? this.entryId,
        entryKey: entryKey ?? this.entryKey,
        entryTranslationFrom: entryTranslationFrom ?? this.entryTranslationFrom,
        entryTranslationTo: entryTranslationTo.present
            ? entryTranslationTo.value
            : this.entryTranslationTo,
        entryLanguageFrom: entryLanguageFrom ?? this.entryLanguageFrom,
        entryLanguageTo: entryLanguageTo ?? this.entryLanguageTo,
        entryGenerated:
            entryGenerated.present ? entryGenerated.value : this.entryGenerated,
      );
  @override
  String toString() {
    return (StringBuffer('SentenceEntry(')
          ..write('id: $id, ')
          ..write('appName: $appName, ')
          ..write('entryId: $entryId, ')
          ..write('entryKey: $entryKey, ')
          ..write('entryTranslationFrom: $entryTranslationFrom, ')
          ..write('entryTranslationTo: $entryTranslationTo, ')
          ..write('entryLanguageFrom: $entryLanguageFrom, ')
          ..write('entryLanguageTo: $entryLanguageTo, ')
          ..write('entryGenerated: $entryGenerated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      appName,
      entryId,
      entryKey,
      entryTranslationFrom,
      entryTranslationTo,
      entryLanguageFrom,
      entryLanguageTo,
      entryGenerated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SentenceEntry &&
          other.id == this.id &&
          other.appName == this.appName &&
          other.entryId == this.entryId &&
          other.entryKey == this.entryKey &&
          other.entryTranslationFrom == this.entryTranslationFrom &&
          other.entryTranslationTo == this.entryTranslationTo &&
          other.entryLanguageFrom == this.entryLanguageFrom &&
          other.entryLanguageTo == this.entryLanguageTo &&
          other.entryGenerated == this.entryGenerated);
}

class EntriesCompanion extends UpdateCompanion<SentenceEntry> {
  final Value<int?> id;
  final Value<String> appName;
  final Value<String> entryId;
  final Value<String> entryKey;
  final Value<String> entryTranslationFrom;
  final Value<String?> entryTranslationTo;
  final Value<String> entryLanguageFrom;
  final Value<String> entryLanguageTo;
  final Value<int?> entryGenerated;
  const EntriesCompanion({
    this.id = const Value.absent(),
    this.appName = const Value.absent(),
    this.entryId = const Value.absent(),
    this.entryKey = const Value.absent(),
    this.entryTranslationFrom = const Value.absent(),
    this.entryTranslationTo = const Value.absent(),
    this.entryLanguageFrom = const Value.absent(),
    this.entryLanguageTo = const Value.absent(),
    this.entryGenerated = const Value.absent(),
  });
  EntriesCompanion.insert({
    this.id = const Value.absent(),
    required String appName,
    required String entryId,
    required String entryKey,
    required String entryTranslationFrom,
    this.entryTranslationTo = const Value.absent(),
    required String entryLanguageFrom,
    required String entryLanguageTo,
    this.entryGenerated = const Value.absent(),
  })  : appName = Value(appName),
        entryId = Value(entryId),
        entryKey = Value(entryKey),
        entryTranslationFrom = Value(entryTranslationFrom),
        entryLanguageFrom = Value(entryLanguageFrom),
        entryLanguageTo = Value(entryLanguageTo);
  static Insertable<SentenceEntry> custom({
    Expression<int>? id,
    Expression<String>? appName,
    Expression<String>? entryId,
    Expression<String>? entryKey,
    Expression<String>? entryTranslationFrom,
    Expression<String>? entryTranslationTo,
    Expression<String>? entryLanguageFrom,
    Expression<String>? entryLanguageTo,
    Expression<int>? entryGenerated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (appName != null) 'app_name': appName,
      if (entryId != null) 'entry_id': entryId,
      if (entryKey != null) 'entry_key': entryKey,
      if (entryTranslationFrom != null)
        'entry_translation_from': entryTranslationFrom,
      if (entryTranslationTo != null)
        'entry_translation_to': entryTranslationTo,
      if (entryLanguageFrom != null) 'entry_language_from': entryLanguageFrom,
      if (entryLanguageTo != null) 'entry_language_to': entryLanguageTo,
      if (entryGenerated != null) 'entry_generated': entryGenerated,
    });
  }

  EntriesCompanion copyWith(
      {Value<int?>? id,
      Value<String>? appName,
      Value<String>? entryId,
      Value<String>? entryKey,
      Value<String>? entryTranslationFrom,
      Value<String?>? entryTranslationTo,
      Value<String>? entryLanguageFrom,
      Value<String>? entryLanguageTo,
      Value<int?>? entryGenerated}) {
    return EntriesCompanion(
      id: id ?? this.id,
      appName: appName ?? this.appName,
      entryId: entryId ?? this.entryId,
      entryKey: entryKey ?? this.entryKey,
      entryTranslationFrom: entryTranslationFrom ?? this.entryTranslationFrom,
      entryTranslationTo: entryTranslationTo ?? this.entryTranslationTo,
      entryLanguageFrom: entryLanguageFrom ?? this.entryLanguageFrom,
      entryLanguageTo: entryLanguageTo ?? this.entryLanguageTo,
      entryGenerated: entryGenerated ?? this.entryGenerated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (appName.present) {
      map['app_name'] = Variable<String>(appName.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (entryKey.present) {
      map['entry_key'] = Variable<String>(entryKey.value);
    }
    if (entryTranslationFrom.present) {
      map['entry_translation_from'] =
          Variable<String>(entryTranslationFrom.value);
    }
    if (entryTranslationTo.present) {
      map['entry_translation_to'] = Variable<String>(entryTranslationTo.value);
    }
    if (entryLanguageFrom.present) {
      map['entry_language_from'] = Variable<String>(entryLanguageFrom.value);
    }
    if (entryLanguageTo.present) {
      map['entry_language_to'] = Variable<String>(entryLanguageTo.value);
    }
    if (entryGenerated.present) {
      map['entry_generated'] = Variable<int>(entryGenerated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntriesCompanion(')
          ..write('id: $id, ')
          ..write('appName: $appName, ')
          ..write('entryId: $entryId, ')
          ..write('entryKey: $entryKey, ')
          ..write('entryTranslationFrom: $entryTranslationFrom, ')
          ..write('entryTranslationTo: $entryTranslationTo, ')
          ..write('entryLanguageFrom: $entryLanguageFrom, ')
          ..write('entryLanguageTo: $entryLanguageTo, ')
          ..write('entryGenerated: $entryGenerated')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final GlobalLanguages globalLanguages = GlobalLanguages(this);
  late final Apps apps = Apps(this);
  late final AppLanguages appLanguages = AppLanguages(this);
  late final Entries entries = Entries(this);
  Selectable<App> getAppById(int? var1) {
    return customSelect('SELECT * FROM apps WHERE id = ?1', variables: [
      Variable<int>(var1)
    ], readsFrom: {
      apps,
    }).asyncMap(apps.mapFromRow);
  }

  Selectable<App> getAppByName(String var1) {
    return customSelect('SELECT * FROM apps WHERE name = ?1', variables: [
      Variable<String>(var1)
    ], readsFrom: {
      apps,
    }).asyncMap(apps.mapFromRow);
  }

  Selectable<SentenceEntry> getSentenceEntriesByAppName(String var1) {
    return customSelect('SELECT * FROM entries WHERE app_name = ?1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          entries,
        }).asyncMap(entries.mapFromRow);
  }

  Selectable<SentenceEntry> checkIsSentenceEntryExist(
      String var1, String var2) {
    return customSelect(
        'SELECT * FROM entries WHERE app_name = ?1 AND entry_key = ?2',
        variables: [
          Variable<String>(var1),
          Variable<String>(var2)
        ],
        readsFrom: {
          entries,
        }).asyncMap(entries.mapFromRow);
  }

  Future<int> setSentenceEntryGenerated(String var1) {
    return customUpdate(
      'UPDATE entries SET entry_generated = 1 WHERE entry_id = ?1',
      variables: [Variable<String>(var1)],
      updates: {entries},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> unsetSentenceEntryGenerated(String var1) {
    return customUpdate(
      'UPDATE entries SET entry_generated = 0 WHERE entry_id = ?1',
      variables: [Variable<String>(var1)],
      updates: {entries},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> setEntryTranslation(String? var1, String var2, String var3) {
    return customUpdate(
      'UPDATE entries SET entry_translation_to = ?1, entry_generated = 1 WHERE app_name = ?2 AND entry_id = ?3',
      variables: [
        Variable<String>(var1),
        Variable<String>(var2),
        Variable<String>(var3)
      ],
      updates: {entries},
      updateKind: UpdateKind.update,
    );
  }

  Selectable<SentenceEntry> getAllSentenceEntryWhereNotGenerated(String var1) {
    return customSelect(
        'SELECT * FROM entries WHERE app_name = ?1 AND entry_generated = 0',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          entries,
        }).asyncMap(entries.mapFromRow);
  }

  Selectable<SentenceEntry> getAllSentenceEntryWhereGenerated(String var1) {
    return customSelect(
        'SELECT * FROM entries WHERE app_name = ?1 AND entry_generated = 1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          entries,
        }).asyncMap(entries.mapFromRow);
  }

  Selectable<SentenceEntry> getAllSentenceEntryWhereNotGeneratedForLang(
      String var1, String var2, String var3) {
    return customSelect(
        'SELECT * FROM entries WHERE app_name = ?1 AND entry_generated = 0 AND entry_language_from = ?2 AND entry_language_to = ?3',
        variables: [
          Variable<String>(var1),
          Variable<String>(var2),
          Variable<String>(var3)
        ],
        readsFrom: {
          entries,
        }).asyncMap(entries.mapFromRow);
  }

  Selectable<SentenceEntry> getAllSentenceEntryWhereGeneratedForLang(
      String var1, String var2, String var3) {
    return customSelect(
        'SELECT * FROM entries WHERE app_name = ?1 AND entry_generated = 1 AND entry_language_from = ?2 AND entry_language_to = ?3',
        variables: [
          Variable<String>(var1),
          Variable<String>(var2),
          Variable<String>(var3)
        ],
        readsFrom: {
          entries,
        }).asyncMap(entries.mapFromRow);
  }

  Future<int> resetAppSentenceEntries(String var1) {
    return customUpdate(
      'UPDATE entries SET entry_generated = 0 WHERE app_name = ?1',
      variables: [Variable<String>(var1)],
      updates: {entries},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> unsetAppGenerated(String var1) {
    return customUpdate(
      'UPDATE apps SET app_generated = 0 WHERE name = ?1',
      variables: [Variable<String>(var1)],
      updates: {apps},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> setAppGenerated(String var1) {
    return customUpdate(
      'UPDATE apps SET app_generated = 1 WHERE name = ?1',
      variables: [Variable<String>(var1)],
      updates: {apps},
      updateKind: UpdateKind.update,
    );
  }

  Selectable<App> getAppGenerated(String var1) {
    return customSelect(
        'SELECT * FROM apps WHERE app_generated = 1 AND name = ?1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          apps,
        }).asyncMap(apps.mapFromRow);
  }

  Future<int> cleanAppEntries(String var1) {
    return customUpdate(
      'DELETE FROM entries WHERE app_name = ?1',
      variables: [Variable<String>(var1)],
      updates: {entries},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> cleanAppLanguages(String var1) {
    return customUpdate(
      'DELETE FROM appLanguages WHERE app_name = ?1',
      variables: [Variable<String>(var1)],
      updates: {appLanguages},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> globalIndexNewLanguage(String var1, String var2) {
    return customInsert(
      'INSERT INTO globalLanguages (language, code) VALUES (?1, ?2)',
      variables: [Variable<String>(var1), Variable<String>(var2)],
      updates: {globalLanguages},
    );
  }

  Future<int> addLangaugeToApp(String var1, String var2, String var3) {
    return customInsert(
      'INSERT INTO appLanguages (app_name, language, language_code) VALUES (?1, ?2, ?3)',
      variables: [
        Variable<String>(var1),
        Variable<String>(var2),
        Variable<String>(var3)
      ],
      updates: {appLanguages},
    );
  }

  Selectable<GlobalLanguage> getLanguageFromGlobalIndex(String var1) {
    return customSelect('SELECT * FROM globalLanguages WHERE language = ?1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          globalLanguages,
        }).asyncMap(globalLanguages.mapFromRow);
  }

  Selectable<AppLanguage> getLanguagesByAppName(String var1) {
    return customSelect('SELECT * FROM appLanguages WHERE app_name = ?1',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          appLanguages,
        }).asyncMap(appLanguages.mapFromRow);
  }

  Selectable<AppLanguage> getAppLanguage(String var1, String var2) {
    return customSelect(
        'SELECT * FROM appLanguages WHERE app_name = ?1 AND language = ?2',
        variables: [
          Variable<String>(var1),
          Variable<String>(var2)
        ],
        readsFrom: {
          appLanguages,
        }).asyncMap(appLanguages.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [globalLanguages, apps, appLanguages, entries];
}
