module.exports =
  up: (migration, DataTypes, done) ->
    migration.createTable 'refuelings',
      id:
        type: DataTypes.INTEGER
        primaryKey: yes
        autoIncrement: yes
      mac: DataTypes.STRING
      total_price: DataTypes.FLOAT
      item_price: DataTypes.FLOAT
      quantity: DataTypes.FLOAT
      type: DataTypes.STRING
      created_at:
        type: DataTypes.DATE
      updated_at:
        type: DataTypes.DATE
    .complete(done)

  down: (migration, DataTypes, done) ->
    migration.dropTable 'refuelings'
    .complete(done)