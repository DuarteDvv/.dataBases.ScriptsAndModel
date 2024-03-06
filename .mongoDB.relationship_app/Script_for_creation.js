use DatingAppDB;

// Coleção de Usuários
db.createCollection("Users");
db.Users.createIndex({ "location": "2dsphere" });

// Coleção de Mensagens
db.createCollection("Messages");

// Coleção de Likes/Matches
db.createCollection("LikesMatches");

// Coleção de Atividades
db.createCollection("Activities");

// Coleção de Bloqueios
db.createCollection("Blocks");

// Adicionar usuários de exemplo
db.Users.insertMany([
  {
    "name": "Alice",
    "age": 28,
    "gender": "Female",
    "location": { "type": "Point", "coordinates": [-73.986613, 40.730610] },
    "interests": ["Reading", "Hiking", "Travel"],
    "profilePhotos": ["alice_photo1.jpg", "alice_photo2.jpg"],
    "bio": "Hello, I love reading books and exploring new places!",
  },
  {
    "name": "Bob",
    "age": 32,
    "gender": "Male",
    "location": { "type": "Point", "coordinates": [-74.006, 40.7128] },
    "interests": ["Sports", "Movies", "Cooking"],
    "profilePhotos": ["bob_photo1.jpg", "bob_photo2.jpg"],
    "bio": "Hi there, I'm passionate about sports and cooking!",
  },
  {
    "name": "Charlie",
    "age": 25,
    "gender": "Male",
    "location": { "type": "Point", "coordinates": [-73.965355, 40.782865] },
    "interests": ["Photography", "Music", "Travel"],
    "profilePhotos": ["charlie_photo1.jpg", "charlie_photo2.jpg"],
    "bio": "Photographer and music enthusiast!",
  },
]);

// Adicionar mensagens de exemplo
db.Messages.insertMany([
  {
    "senderId": ObjectId("user_id_1"),
    "recipientId": ObjectId("user_id_2"),
    "content": "Hello, how are you?",
    "timestamp": new Date(),
    "readStatus": false,
  },
  {
    "senderId": ObjectId("user_id_2"),
    "recipientId": ObjectId("user_id_1"),
    "content": "Hi Alice, I'm good! How about you?",
    "timestamp": new Date(),
    "readStatus": false,
  },
]);

// Adicionar likes/matches de exemplo
db.LikesMatches.insertMany([
  {
    "userIdSender": ObjectId("user_id_1"),
    "userIdReceiver": ObjectId("user_id_2"),
    "timestamp": new Date(),
    "matchStatus": true,
  },
  {
    "userIdSender": ObjectId("user_id_2"),
    "userIdReceiver": ObjectId("user_id_1"),
    "timestamp": new Date(),
    "matchStatus": true,
  },
]);

// Adicionar atividades de exemplo
db.Activities.insertMany([
  {
    "userId": ObjectId("user_id_1"),
    "activityType": "New Match",
    "timestamp": new Date(),
    "activityStatus": "unread",
  },
  {
    "userId": ObjectId("user_id_2"),
    "activityType": "New Match",
    "timestamp": new Date(),
    "activityStatus": "unread",
  },
]);

// Adicionar bloqueios de exemplo
db.Blocks.insertMany([
  {
    "blockerId": ObjectId("user_id_1"),
    "blockedUserId": ObjectId("user_id_3"),
  },
  {
    "blockerId": ObjectId("user_id_3"),
    "blockedUserId": ObjectId("user_id_1"),
  },
]);

