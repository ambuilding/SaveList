# SaveList
Core Data 

- Modeling your data

create a managed object model;
Entities sound a lot like a classes. Attributes/relationships sound a lot like properties. 
What’s the difference? 
You can think of a Core Data entity as a class “definition” 
and the managed object as an instance of that class.

- Saving to Core Data

NSManagedObject represents a single object stored in Core Data—you must use it to
create, edit, save and delete from your Core Data persistent store. 

save() do { try } catch {}

- Fetching from Core Data

Pull up the application delegate and grab a reference to its managed object context.
NSEntityDescription;
executeFetchRequest() returns an array of managed objects that meets the criteria specified by the fetch request
