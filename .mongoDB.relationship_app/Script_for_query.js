// name of all the users with age > 25
db.Users.find(
  {
    age: {
      $gt: 25 
    }
  },
  {
    name:1
  }
)

// return the older users registered

db.Users.find().sort(
  {
    age:-1
  }
).limit(1).pretty()

// return all the girls with hobbie read, age > 25 and max distance 10000 KM

db.Users.find(
  { 
    age: { $gt: 25 }, 
    gender: "Female", 
    interests: "Reading", 
    location: { $near: { $geometry: { type: "Point", coordinates: [-46.6333, -23.5505] }, $maxDistance: 10000000 } } 
  }
);

// users with hobbies x

 db.Users.find(
   {
     interests: {$in:['Reading','Sports','Movies']}
   }
 )

// users with age <26 and >29

 db.Users.find(
   {
     $or:
       [
         {
           age:{
             $gt:29
           }
         },
         {
           age:{
             $lt:26
           }
         }
       ]
   }
 )

// all messages by two people

db.Messages.find({
  $or: [
    { senderId: ObjectId("user_id_1"), recipientId: ObjectId("user_id_2") },
    { senderId: ObjectId("user_id_2"), recipientId: ObjectId("user_id_1") },
  ],
});

// users who matched

db.LikesMatches.find({
  $and: [
    { senderId: { $in: [ObjectId("user_id_1"), ObjectId("user_id_2")] } },
    { recipientId: { $in: [ObjectId("user_id_1"), ObjectId("user_id_2")] } },
    { matchState: "matched" },
  ],
});



