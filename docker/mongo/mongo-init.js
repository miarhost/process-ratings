db.auth('admin-user', 'admin-password')

db = db.getSiblingDB('mg-process-ratings')
db.createUser(
  {
    user: 'mongouser',
    pwd: 'mongopwd',
    roles: [
      {
        role: "readWrite",
        db: 'mg-process-ratings'
      }
    ]
  }
);
db.createCollection('ratings_list');
db.ratings_list.insertOne(
  {
    testRecord: 'Initial ratings record'
  }
);
