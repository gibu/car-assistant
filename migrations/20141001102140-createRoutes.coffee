module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'routes',
      id:
        type: DataTypes.INTEGER
        primaryKey: yes
        autoIncrement: yes
      duration: DataTypes.FLOAT
      length: DataTypes.FLOAT
      mac: DataTypes.STRING
      created_at:
        type: DataTypes.DATE
      updated_at:
        type: DataTypes.DATE
    .complete(done)

  down: (migration, DataTypes, done) ->
    migration.dropTable 'routes'
    .complete(done)