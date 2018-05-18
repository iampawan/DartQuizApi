import 'package:aqueduct/aqueduct.dart';   
import 'dart:async';

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   database.createTable(new SchemaTable("_Question", [
new SchemaColumn("index", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
new SchemaColumn("description", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
],
));

database.createTable(new SchemaTable("_Answer", [
new SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
new SchemaColumn("description", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
new SchemaColumn.relationship("question", ManagedPropertyType.bigInteger, relatedTableName: "_Question", relatedColumnName: "index", rule: ManagedRelationshipDeleteRule.cascade, isNullable: false, isUnique: true),
],
));


  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    