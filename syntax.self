



"this is a comment"

"
comments can 
be multiline too.
"

"point creates a new object. x and y are slots. '.' is the separator"
point = (|
  x = 0.
  y = 0.
|)


"you can access slots by sending messages to them"
point x.

"slot assignments with '=' are read-only (immutable)by default. if you want assigneable (mutable) slots then use '<-'"

point = (|
  x <- 0.
|)

point x: 50.


"local variables are declared outside of objects, between vertical bars"
| a b result |
a = 10.
b = 10.
result = a + b.
result printLine.


"methods"
calculator = (|
  a = 0.
  b = 0.

  add = (a + b).
  subtract = (a-b).
|)

"methods are executed when they receive messages"
calculator add.
calculator subtract.

"-----------------------------------------------------------"

"message types"

"unary messages: no arguments, e.g. calling a method"
calculator add.


"binary messages: one argument using operators"
1 + 2.

"keyword messages: arguments identified by keywords"
point x = 10.


"-----------------------------------------------------------"

"blocks and control flows"

"blocks are like anonymous lambda functions"
"creates a block with 10 + 20. value calls the block and executes it."
[ 10 + 20 ] value.

"block with local variables"
[ 
  | x |
  x = 10.
  x + 5.
] value.


"conditionals. ifTrue executes a block directly without the need to pass 'value' as an executor. it only executes the block if ifTrue is satisfied"
(10 > 5) ifTrue: [
    'Condition is true!' printLine.
].

"multiple conditionals."
(10 > 5)
    ifTrue: [ 'YES' printLine. ] "this is a block"
    False: [ 'NO' printLine. ]. "this is a block too"



"loops. whileTrue is the same principle as ifTrue but it just loop executes the block if the condition is matched"

| i | "first declare a local variable and initialize its value"
i = 1.

"here, whileTrue EXPECTS a block which evaluates / checks for a condition. if that is matched, it will execute a body block."
[i <= 5] whileTrue: [
    i printLine.
    i: i + 1.
].


[
  'running...' printLine
] loop. "loop executes the block forever."


"prototype inheritance. with inheritance you can delegate methods from one object to its child."
animal = (|
  speak = (
    'hello' printLine
  ).
|)

dog = (|
  parent* = object1. "dog now has the speak method of animal."
  bark = (
    'woof' printLine
  ).
|)


animal speak. "this will invoke the speak method of animal object and print 'hello'"
dog bark. "this will invoke the bark method of dog object and print 'woof'"
dog speak. "this inherits the SPEAK method of its parent object which is animal."


"
the flow here is:

1. Self looks for speak inside dog.
2. It cannot find speak.
3. It follows the parent* slot to animal.
4. It finds speak inside animal.
5. It executes the method.
"


"same thing works with multiple parents on one object.:"
walker = (|
  walk = ( 'walking' printLine).
|)

swimmer = (|
  swim = ('swimming' printLine).
|)

duck = (|
  parentWalker* = walker.
  parentSwimmer* = swimmer.
  quack = ('quack' printLine).
|)

duck quack. "quack"
duck walk. "walker walk"
duck swim. "swimmer swim"


"resending messages: this is a powerful concept when a child object overrides a method of its parent but still want to preserve its parents functionality."

animal = (|
  speak = ('meow' printLine).
|)

"note: dog speak overrides animal.speak because animal is its parent. resend.speak invokes the original animal.speak."
dog = (|
  parent* = animal.
  speak = (
    'dog says: ' printLine. 
    resend.speak.
  ).
|)



"copying objects"
person = (|
  name <- 'asas'.
|)

anotherPerson = person copy. "same object as person"
anotherPerson name: 'alice'.


"-----------------------------------------------------------"

"lists, dicts and iterations"


"lists store multiple elements in sequence"

numbers = list copy. "this creates a new object called numbers by copying the 'list' object"

"you can add elements to the list using 'add:' "
numbers add: 10.
numbers add: 20.
numbers add. 30.

"conceptually its now: [10, 20, 30]"

"accessing elemts can be achieved using 'at:'"
numbers at: 0. "prints 10"
numbers printLine. "prints the whole list"

"dicts / dictionaries, store key-value pairs."
person = dict copy. "again copy the dict object into our object"
person at: 'name' Put: 'alice'.
person at: 'age' Put: '25'. "same thing works with lists to but the elements need to be all the same type" 


"iteration: a collection such a list or a dict can provide an iteration message such as 'do:' to loop over every element."
numbers = list copy.
numbers add: 1.
numbers add: 2.
numbers add: 3.
"now lets print all elements."

numbers do: [
  | :i |
  i printLine.
]. 

"note 'do:' again requires a block as its body. inside the block we can define a special local variable called ':i' which provides access to the value of the current iteration. this is very similar to a for loop in every other language"

"we can also add conditional flows inside iterations."
"its as easy as in every other block."
numbers do: [
  | :i |
  (i > 15) ifTrue: [
    i printLine.
  ].
].


"-----------------------------------------------------------"



"mirrors and reflection"

"mirrors allow you to inspect an object and all of its slots & methods in realtime during runtime without affecting it or changing it"
"assume following:"
test = (|
  hey = ('hey' printLine).
|)

person = (|
  parent* = test.
  name <- 'alice'. "mutable data slot"
  age = 25. "immutable data slot"
  greet = ( 'hello' printLine). "method"
|)

"now create a mirror that reflects the 'person' object"
mirror = reflect: person. "now we can inspect person object through mirror."
mirror reflectee. "returns person."

mirror contentsAt: 'name'. "returns value of name dataslot of person object"
mirror isAssigneableAt: 'age'. "checks the age dataslot of person object and returns a binary boolean if it is mutable. in this case its 0 / false."

mirror isParentAt: 'test'. "checks if the test slot of person object has a parent. returns 1 in this case (true)"


mirror isArgumentAt: 'name'. "checks if the name slot of person object is an argumentchecks if the name slot of person object is an argument"
mirror slotAt: 'name'. "allows u to inspect the current value of person.name"



"cool things you can do with mirrors and reflection:"

inspector = (| "create an object called inspector"
  inspectObject: obj = ( "create a method called inspectObject that accepts an argument called obj"
    | m | "local variable called m"

    m: reflect: obj. "create a mirror of the object passed as argument to the method inside m"

    m reflectee printLine. "print the reflectee of m. -> person"

    m do: [| :slot | "iterate over each slot in the reflectee"
      slot printLine. "print the current slot"
    ].
  ).
|)

inspector inspectObject: person. 





"-----------------------------------------------------------"



"traits: reusable objects"

"traits are really cool:"

"this is a trait with the name animal. (traits are technically just objects defined inside of objects"
traits = (|
  animal = (|
    walk = ('Walking...' printLine).
    sleep = ('Sleeping...' printLine).
    "create 100s of more methods here. doesnt really matter"
  |).
|)

"now we define an object that inherits the animal trait via parent*"
"this is handy, much better than having hundreds of methods inside dog and cat."
dog = (|
  parent* = traits animal.
  speak = ('Woof!' printLine).
|)
cat = (|
  parent* = traits animal.
  speak = ('Meow!' printLine).
|)

dog walk. "inherited by the trait. -> 'walking'"
dog sleep. "inherited by the trait. -> 'sleeping'"
dog speak. "its own method -> 'woof'"

"now it gets a bit confusing... why would you inherit the animal trait into dog and cat if you could just create the walk and sleep methods directly inside trait and inherit whole trait object to dog and cat via parent*?. well its simple. when you inherit the whole trait object via parent* then you inherit ALL of that object including slots and other methods. with a trait you can SELECTIVELY inherit methods and slots. not the full object."






"todo:

- list of builtins such as printLine, ifTrue, ifFalse, whileTrue etc.
"
