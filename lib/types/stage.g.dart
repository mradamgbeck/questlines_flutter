// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStageCollection on Isar {
  IsarCollection<Stage> get stages => this.collection();
}

const StageSchema = CollectionSchema(
  name: r'Stage',
  id: -7840862827543848208,
  properties: {
    r'complete': PropertySchema(
      id: 0,
      name: r'complete',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'questId': PropertySchema(
      id: 2,
      name: r'questId',
      type: IsarType.long,
    ),
    r'selected': PropertySchema(
      id: 3,
      name: r'selected',
      type: IsarType.bool,
    )
  },
  estimateSize: _stageEstimateSize,
  serialize: _stageSerialize,
  deserialize: _stageDeserialize,
  deserializeProp: _stageDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _stageGetId,
  getLinks: _stageGetLinks,
  attach: _stageAttach,
  version: '3.1.0+1',
);

int _stageEstimateSize(
  Stage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _stageSerialize(
  Stage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.complete);
  writer.writeString(offsets[1], object.name);
  writer.writeLong(offsets[2], object.questId);
  writer.writeBool(offsets[3], object.selected);
}

Stage _stageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Stage();
  object.complete = reader.readBool(offsets[0]);
  object.id = id;
  object.name = reader.readString(offsets[1]);
  object.questId = reader.readLong(offsets[2]);
  object.selected = reader.readBool(offsets[3]);
  return object;
}

P _stageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stageGetId(Stage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _stageGetLinks(Stage object) {
  return [];
}

void _stageAttach(IsarCollection<dynamic> col, Id id, Stage object) {
  object.id = id;
}

extension StageQueryWhereSort on QueryBuilder<Stage, Stage, QWhere> {
  QueryBuilder<Stage, Stage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StageQueryWhere on QueryBuilder<Stage, Stage, QWhereClause> {
  QueryBuilder<Stage, Stage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Stage, Stage, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Stage, Stage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Stage, Stage, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StageQueryFilter on QueryBuilder<Stage, Stage, QFilterCondition> {
  QueryBuilder<Stage, Stage, QAfterFilterCondition> completeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'complete',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> questIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questId',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> questIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questId',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> questIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questId',
        value: value,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> questIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stage, Stage, QAfterFilterCondition> selectedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selected',
        value: value,
      ));
    });
  }
}

extension StageQueryObject on QueryBuilder<Stage, Stage, QFilterCondition> {}

extension StageQueryLinks on QueryBuilder<Stage, Stage, QFilterCondition> {}

extension StageQuerySortBy on QueryBuilder<Stage, Stage, QSortBy> {
  QueryBuilder<Stage, Stage, QAfterSortBy> sortByComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'complete', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortByCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'complete', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortByQuestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortByQuestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortBySelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selected', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> sortBySelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selected', Sort.desc);
    });
  }
}

extension StageQuerySortThenBy on QueryBuilder<Stage, Stage, QSortThenBy> {
  QueryBuilder<Stage, Stage, QAfterSortBy> thenByComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'complete', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByCompleteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'complete', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByQuestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenByQuestIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questId', Sort.desc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenBySelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selected', Sort.asc);
    });
  }

  QueryBuilder<Stage, Stage, QAfterSortBy> thenBySelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selected', Sort.desc);
    });
  }
}

extension StageQueryWhereDistinct on QueryBuilder<Stage, Stage, QDistinct> {
  QueryBuilder<Stage, Stage, QDistinct> distinctByComplete() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'complete');
    });
  }

  QueryBuilder<Stage, Stage, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Stage, Stage, QDistinct> distinctByQuestId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questId');
    });
  }

  QueryBuilder<Stage, Stage, QDistinct> distinctBySelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selected');
    });
  }
}

extension StageQueryProperty on QueryBuilder<Stage, Stage, QQueryProperty> {
  QueryBuilder<Stage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Stage, bool, QQueryOperations> completeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'complete');
    });
  }

  QueryBuilder<Stage, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Stage, int, QQueryOperations> questIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questId');
    });
  }

  QueryBuilder<Stage, bool, QQueryOperations> selectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selected');
    });
  }
}
