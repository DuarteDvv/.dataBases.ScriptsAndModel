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
  });

