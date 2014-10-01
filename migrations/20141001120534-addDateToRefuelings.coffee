module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn('refuelings', 'date', DataTypes.DATE)
    .complete (done)

  down: (migration, DataTypes, done) ->
    migration.removeColumn('refuelings', 'date')
    .complete (done)