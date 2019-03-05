
# run mongodb shell
> mongo

# Print a list of all databases
> show dbs

# Create/switch to school database
> use school;

# Print a list of all collections in school database
> show collections;

# Create/Insert collections 
# db.collection.insert()	

db.student.insert(
[{
  "id": 1,
  "first_name": "Jeanette",
  "last_name": "Penddreth",
  "email": "jpenddreth0@census.gov",
  "gender": "Female",
  "ip_address": "26.58.193.2"
}, {
  "id": 2,
  "first_name": "Giavani",
  "last_name": "Frediani",
  "email": "gfrediani1@senate.gov",
  "gender": "Male",
  "ip_address": "229.179.4.212"
}, {
  "id": 3,
  "first_name": "Noell",
  "last_name": "Bea",
  "email": "nbea2@imageshack.us",
  "gender": "Female",
  "ip_address": "180.66.162.255"
}, {
  "id": 4,
  "first_name": "Willard",
  "last_name": "Valek",
  "email": "wvalek3@vk.com",
  "gender": "Male",
  "ip_address": "67.76.188.26"
}]
);

# Find all documents in the collection 
# db.collection.find()	
# db.collection.find().pretty()	

>  db.students.find().pretty();

# Find all documents that has first name = Noell

> db.students.find({"first_name":"Noell"}).pretty();


# Find all documents that has first name = Noell, and display only first and last name

> db.students.find({"first_name":"Noell"},{"first_name":true,"last_name":true}).pretty();

# Find all documents, display only first and last name and sorted by last_name in ascending 
# Ascending order (1), descending (-1) order

> db.students.find({},{"first_name":true,"last_name":true}).sort( { last_name: 1 } ).pretty();


# Find all documents, display only the first two documents 

> db.students.find({}).limit(2).pretty();

### **** MongoDB CRUD Operations *** ####

# Create Operations

> db.collection.insertOne() 
> db.collection.insertMany() 

# Read Operations

> db.collection.find()


# Update Operations

> db.collection.updateOne() 
> db.collection.updateMany()
> db.collection.replaceOne()

## example
db.students.updateOne({"first_name" : {$eq:"Giavani"} },
						 {$set: {"first_name" : "John"}});

#Delete Operations

> db.collection.deleteOne() 
> db.collection.deleteMany() 

## example
db.students.deleteOne({"first_name" : "John"});
