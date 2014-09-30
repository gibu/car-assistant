module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'cars',
      id:
        type: DataTypes.INTEGER
        primaryKey: yes
        autoIncrement: yes
      make: DataTypes.STRING
      model: DataTypes.STRING
      year: DataTypes.INTEGER
      engine: DataTypes.STRING
      fuel: DataTypes.STRING
      fuel_capacity: DataTypes.FLOAT
      fuel_consumption: DataTypes.FLOAT
      mac: DataTypes.STRING
      created_at:
        type: DataTypes.DATE
      updated_at:
        type: DataTypes.DATE
    .complete(done)

  down: (migration, DataTypes, done) ->
    migration.dropTable 'cars'
    .complete(done)