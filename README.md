# Implicit Self

## Learning Goals

- Identify when `self` is being used implicitly in a method
- Identify cases when using implicit `self` won't work

## Introduction

As you've seen, the `self` keyword in Ruby is a very important concept and a
powerful tool of abstraction that makes our objects self-aware. We know that
when defining an instance method, we can use `self` to call other instance
methods within the same class.

Taking an example from a previous lesson:

```rb
class Dog
  attr_accessor :name, :owner

  def initialize(name)
    @name = name
  end

  def bark
    puts "Woof!"
  end

  def get_adopted(owner_name)
    self.owner = owner_name
  end

end
```

We can see that in the `Dog#get_adopted` method, we're able to call the
`self.owner=` method to refer to the `Dog#owner=` setter method.

We can use the same technique to refer to any other instance methods in the
class as well. For example, if we wanted our dog to bark when they get adopted,
we could refactor our code as follows:

```rb
class Dog
  attr_accessor :name, :owner

  def initialize(name)
    @name = name
  end

  def bark
    puts "Woof!"
  end

  def get_adopted(owner_name)
    self.bark # calls the Dog#bark method
    self.owner = owner_name
  end

end
```

Now, when we call the `#get_adopted` method on a dog, it'll both bark and get a
new owner assigned:

```rb
fido = Dog.new("Fido")
fido.get_adopted("Sophie")
# "Woof!"
# => "Sophie"
```

## Using the Implicit Receiver

In Ruby, there is one other technique we can use to call other instance methods
from each other within a single class. In the example above, we are using the
**explicit receiver** syntax by writing `self.bark`, where `self` is
**receiving** the `#bark` method.

However, we can also use the **implicit receiver** syntax, and _omit_ the `self`
keyword when calling other instance methods:

```rb
class Dog
  attr_accessor :name, :owner

  def initialize(name)
    @name = name
  end

  def bark
    puts "Woof!"
  end

  def get_adopted(owner_name)
    bark # implicit receiver will be self
    self.owner = owner_name
  end

end
```

When Ruby encounters a bareword, like `bark`, it will attempt to use that as a
method and call it on `self`. Some [style guides][explicit self] suggest using
this "implicit receiver", or "implicit self" syntax, and you'll often encounter
it in other Ruby code, so it's good to recognize this syntax.

> **Note**: For the most part, our labs will use the explicit `self` syntax in
> examples and in the solution code for sake of clarity. Since `self` is a
> tricky concept, being explicit can help demonstrate how `self` is used.

## When the Implicit Receiver Doesn't Work

You'll notice in this example, our `#get_adopted` method still refers to the
`self.owner=` method with the explicit receiver syntax. Why is this? Well, let's
see what this method would look like without the explicit self:

```rb
class Dog
  attr_accessor :name, :owner

  def initialize(name)
    @name = name
  end

  def bark
    puts "Woof!"
  end

  def get_adopted(owner_name)
    bark # implicit receiver will be self
    owner = owner_name
  end

end
```

In this case, the line `owner = owner_name` is treated as a _variable
assignment_ instead of a _method call_. Remember, the setter method `#owner=`
allows some syntax sugar when you're using it (which is why we don't have to
write `dog.owner=("Sophie")` when calling that method). Because of this syntax
sugar, however, we're not able to use the implicit `self` syntax with setter
methods.

## Conclusion

In this lesson, you learned how to recognize when `self` is being used
implicitly in method calls, as well as where explicit `self` is required.
Getting used to this implicit syntax in Ruby takes some getting used to (just
like the implicit return from methods), so our recommendation is to practice
using explicit `self` first until you are confident with what `self` is in any
given method before using the implicit syntax.

## Resources

- [Ruby's Self Keyword and Implicit Self](https://codequizzes.wordpress.com/2014/04/07/rubys-self-keyword-and-implicit-self/)
- [Ruby Style Guide: Explicit Self][explicit self]

[explicit self]: https://rubystyle.guide/#no-self-unless-required
