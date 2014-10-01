module.exports =
  up: (migration, DataTypes, done) ->
    migration.addColumn('routes', 'date', DataTypes.DATE)
    .complete (done)

  down: (migration, DataTypes, done) ->
    migration.removeColumn('routes', 'date')
    .complete (done)