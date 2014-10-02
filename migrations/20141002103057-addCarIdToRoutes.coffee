module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn('routes', 'car_id',
      {
        type: DataTypes.INTEGER,
        references: "cars",
        referenceKey: "id",
        onUpdate: "CASCADE",
        onDelete: "RESTRICT"
      }).complete (done)

  down: (migration, DataTypes, done) ->
    migration.removeColumn('routes', 'car_id')
    .complete (done)
