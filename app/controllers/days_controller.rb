# Demo classes/modules for Day 1 - Ruby object model, classes, objects, self
module Day1Examples
  class Animal
    def initialize(name, sound)
      @name = name
      @sound = sound
    end

    def speak
      "#{@name} says #{@sound}"
    end
  end

  class SelfDemo
    def instance_method_self
      "self inside an instance method => #{self}"
    end

    def self.class_method_self
      "self inside a class method => #{self}"
    end
  end

  class Book
    attr_accessor :title

    def initialize(title)
      @title = title
    end
  end
end

# Demo methods for Day 2 - methods, blocks, yield
# Everything below uses ONE running story - ordering at a coffee shop -
# so a beginner only has to hold one scenario in their head for the whole page.
module Day2Examples
  def self.order_coffee(size = "Medium")
    "Ordering a #{size} coffee"
  end

  def self.add_toppings(*toppings)
    return "Just a plain coffee, no toppings" if toppings.empty?

    "Coffee with: #{toppings.join(", ")}"
  end

  def self.order_details(size:, sugar: 1)
    "#{size} coffee with #{sugar} sugar(s)"
  end

  def self.make_coffee
    return "No instructions given - making a plain coffee" unless block_given?

    "Following your instructions: #{yield}"
  end

  def self.make_coffee_n_times(n, &instructions)
    results = []
    n.times { |i| results << instructions.call(i + 1) }
    results
  end
end

# Demo methods for Day 3 - Procs vs Lambdas
module Day3Examples
  def self.add_with_proc
    Proc.new { |a, b| a + b }
  end

  def self.add_with_lambda
    lambda { |a, b| a + b }
  end

  def self.square(number)
    my_lambda = ->(n) { n * n }
    my_lambda.call(number)
  end

  def self.call_lambda_with_missing_argument
    strict = ->(a, b) { a + b }
    strict.call(1)
  rescue ArgumentError => e
    "Error! #{e.message}"
  end

  def self.call_proc_with_missing_argument
    relaxed = Proc.new { |a, b| "a=#{a}, b=#{b}" }
    relaxed.call(1)
  end

  def self.proc_stops_the_whole_method
    my_proc = Proc.new { return "stopped everything!" }
    my_proc.call
    "you will never see this line"
  end

  def self.lambda_only_stops_itself
    my_lambda = lambda { return "just stopped the lambda" }
    my_lambda.call
    "this line still runs!"
  end
end

# Demo classes/modules for Day 4 - Modules, Mixins, Namespaces
module Day4Examples
  # a plain module used as a toolbox - you never create objects from it
  module MathHelpers
    def self.square(x)
      x * x
    end
  end

  # a module meant to be "mixed in" (included) into a class
  module Greetable
    def greet
      "Hi, I'm #{name}!"
    end
  end

  class Person
    include Greetable
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  # same module, used to show include vs extend
  module Flyable
    def fly
      "I'm flying!"
    end
  end

  class Bird
    include Flyable # every Bird object gets #fly
  end

  class Robot
    extend Flyable # the Robot class itself gets .fly
  end

  # two classes with the SAME name, kept apart by their namespace
  module Shop
    class Order
      def summary
        "An order from the Shop module"
      end
    end
  end

  module Warehouse
    class Order
      def summary
        "An order from the Warehouse module"
      end
    end
  end
end

# Demo classes for Day 5 - OOP: inheritance vs composition
module Day5Examples
  # Inheritance ("is-a"): Dog IS an Animal
  class Animal
    def initialize(name)
      @name = name
    end

    def eat
      "#{@name} is eating"
    end
  end

  class Dog < Animal
    def bark
      "#{@name} says Woof!"
    end
  end

  # super: overriding a method but still calling the parent's version
  class LoudDog < Animal
    def eat
      super + ", loudly!"
    end
  end

  # Composition ("has-a"): Car HAS an Engine, it is not an Engine
  class Engine
    def start
      "Engine started"
    end
  end

  class Car
    def initialize
      @engine = Engine.new
    end

    def start
      @engine.start
    end
  end
end

# Demo methods for Day 6 - Enumerable (map, select, reduce, etc.)
module Day6Examples
  def self.double_all(numbers)
    numbers.map { |n| n * 2 }
  end

  def self.keep_evens(numbers)
    numbers.select { |n| n.even? }
  end

  def self.remove_evens(numbers)
    numbers.reject { |n| n.even? }
  end

  def self.sum_all(numbers)
    numbers.reduce(0) { |sum, n| sum + n }
  end

  def self.first_greater_than(numbers, limit)
    numbers.find { |n| n > limit }
  end

  def self.sorted(numbers)
    numbers.sort
  end

  def self.evens_times_ten_summed(numbers)
    numbers.select { |n| n.even? }.map { |n| n * 10 }.reduce(0) { |sum, n| sum + n }
  end
end

# Demo classes for Day 7 - Review + build a small CLI app
# Combines Day 1 (classes), Day 4 (mixins), and Day 6 (Enumerable) into one small program.
module Day7Examples
  class Task
    attr_accessor :title, :done

    def initialize(title)
      @title = title
      @done = false
    end

    def to_s
      "[#{done ? "x" : " "}] #{title}"
    end
  end

  module Loggable
    def log(message)
      "LOG: #{message}"
    end
  end

  class TaskManager
    include Loggable

    def initialize
      @tasks = []
    end

    def add(title)
      @tasks << Task.new(title)
      log("Added task: #{title}")
    end

    def complete(index)
      @tasks[index].done = true
      log("Completed task: #{@tasks[index].title}")
    end

    def list
      @tasks.map(&:to_s)
    end

    def pending_count
      @tasks.count { |task| !task.done }
    end
  end
end

# Demo methods for Day 8 - Exception handling
module Day8Examples
  def self.safe_divide(a, b)
    a / b
  rescue ZeroDivisionError
    "Can't divide by zero!"
  end

  def self.check_age(age)
    raise ArgumentError, "Age can't be negative" if age < 0

    "Age is valid: #{age}"
  end

  def self.check_age_safely(age)
    check_age(age)
  rescue ArgumentError => e
    "Blocked: #{e.message}"
  end

  class InsufficientFundsError < StandardError; end

  def self.withdraw(balance, amount)
    raise InsufficientFundsError, "Not enough money! Balance is #{balance}" if amount > balance

    balance - amount
  end

  def self.withdraw_safely(balance, amount)
    "New balance: #{withdraw(balance, amount)}"
  rescue InsufficientFundsError => e
    "Blocked: #{e.message}"
  end

  def self.process_with_ensure(should_fail)
    log = []
    begin
      raise "Something went wrong!" if should_fail

      log << "Payment processed successfully"
    rescue StandardError => e
      log << "Rescued an error: #{e.message}"
    ensure
      log << "Ensure block ran - this ALWAYS happens"
    end
    log
  end
end

# Demo methods for Day 9 - File I/O and JSON
module Day9Examples
  DEMO_FILE = Rails.root.join("tmp", "day9_demo_notes.txt")

  def self.write_and_read_file
    File.write(DEMO_FILE, "Hello from Ruby!\nThis is stored in a real file.")
    existed = File.exist?(DEMO_FILE)
    content = File.read(DEMO_FILE)
    File.delete(DEMO_FILE)
    { existed: existed, content: content }
  end

  def self.ruby_to_json
    data = { name: "Ali", age: 25, skills: ["Ruby", "Rails"] }
    data.to_json
  end

  def self.json_to_ruby_with_string_keys
    JSON.parse(ruby_to_json)
  end

  def self.json_to_ruby_with_symbol_keys
    JSON.parse(ruby_to_json, symbolize_names: true)
  end

  def self.save_and_load_json
    data = { title: "Learn Ruby", done: false }
    File.write(DEMO_FILE, data.to_json)
    loaded = JSON.parse(File.read(DEMO_FILE))
    File.delete(DEMO_FILE)
    loaded
  end
end

# Demo methods for Day 10 - Symbols vs Strings, memory basics
module Day10Examples
  def self.symbol_class
    :hello.class
  end

  def self.string_class
    "hello".class
  end

  def self.same_symbol_same_object
    a = :name
    b = :name
    a.object_id == b.object_id
  end

  def self.different_string_different_object
    a = "name"
    b = "name"
    a.object_id == b.object_id
  end

  def self.mutate_a_string
    str = "hello"
    str << " world"
    str
  end

  def self.try_mutate_a_symbol
    :hello.frozen?
  end

  def self.hash_with_symbol_keys
    { name: "Ali", age: 25 }
  end
end

class DaysController < ApplicationController
  QUESTIONS = [
    {
      day: 1,
      title: "Ruby object model, classes, objects, self",
      path: :day1_path,
      items: [
        { q: "What is a class?",
          a: "A blueprint for building objects — think of it like a cookie cutter. It describes what data (instance variables) and behavior (methods) every object made from it will have. A single Dog class, for example, can stamp out as many dog objects as you want, each with its own name." },
        { q: "What is an object?",
          a: "One specific thing built from a class — like one actual cookie cut from the cutter. Each object gets its own copy of the instance variables (its own data), but every object from the same class shares the exact same methods (behavior)." },
        { q: "What is self?",
          a: "self simply means \"whoever is running this code right now,\" and it changes depending on where you are. Inside a normal (instance) method, self is the object that called it. Inside a class method (def self.something) or directly in the class body, self is the class itself." },
        { q: "What does \"everything is an object\" mean?",
          a: "In Ruby, you can't find anything that isn't an object — numbers, strings, nil, true/false, arrays, and even classes themselves. Every single one belongs to some class, which you can check yourself: 5.class => Integer, \"hi\".class => String." },
        { q: "What does attr_accessor do?",
          a: "Normally you'd write one method to read a variable (a getter) and another to change it (a setter) by hand. attr_accessor :title writes both of those for you automatically, so book.title reads it and book.title = \"New\" changes it — no manual code needed." }
      ]
    },
    {
      day: 2,
      title: "Methods, blocks, yield",
      path: :day2_path,
      items: [
        { q: "What is a default argument?",
          a: "A method parameter that already has a fallback value built in. If whoever calls the method skips that argument, Ruby just uses the default instead of raising an error — e.g. def greet(name = \"Guest\") means calling greet() with nothing still works fine." },
        { q: "What is a splat argument (*args)?",
          a: "Normally a method expects an exact number of arguments. Adding a splat, like *numbers, lets it accept any amount at all — zero, one, or a hundred — and Ruby automatically gathers them all into a single array you can use inside the method." },
        { q: "What are keyword arguments?",
          a: "Instead of relying on the order you pass values in, keyword arguments let you label each one by name, like build_profile(name: \"Ali\", age: 20). This makes the method call easier to read, and lets you skip any argument that already has a default." },
        { q: "What is a block?",
          a: "A block is a chunk of code you attach to a method call, written with { ... } for something short or do...end for multiple lines. Attaching it doesn't run it immediately — the method itself decides whether, and when, to actually run that code." },
        { q: "What does yield do?",
          a: "Written inside a method, yield jumps out to run whatever block was attached when the method was called. A method can yield more than once, and can even pass values into the block each time it does." },
        { q: "What is block_given??",
          a: "Not every call to a method includes a block, so block_given? lets the method check first — \"did I actually get a block this time?\" — before trying to yield, so it doesn't crash with an error when there wasn't one." },
        { q: "What does &block do?",
          a: "Adding &block as the very last parameter turns the attached block into a real object (a Proc) that you can save into a variable, hand off to another method, or run yourself later with block.call — more flexible than only being able to yield it once, right there." }
      ]
    },
    {
      day: 3,
      title: "Procs vs Lambdas",
      path: :day3_path,
      items: [
        { q: "What is a Proc?",
          a: "A small chunk of code saved into a variable, like packing instructions into a box. Later, whoever is holding that box can run the instructions whenever they want, just by calling .call on it." },
        { q: "What is a Lambda?",
          a: "A Lambda does the exact same job as a Proc — you make it once, then call it later — but it's pickier about how it's used: it double-checks the number of arguments you give it, and return behaves like a normal method's return instead of something more drastic." },
        { q: "What's the difference between them?",
          a: "Two real differences to remember: (1) a lambda raises an error if you call it with the wrong number of arguments, while a proc just lets it slide and fills in nil for anything missing; (2) return inside a proc exits the whole method it was created in, while return inside a lambda only exits the lambda itself." },
        { q: "How do you check if something is a lambda?",
          a: "Both Procs and Lambdas are technically instances of the same Proc class in Ruby, so calling .lambda? on one tells you which kind it actually is — true for a lambda, false for a plain proc." }
      ]
    },
    {
      day: 4,
      title: "Modules, Mixins, Namespaces",
      path: :day4_path,
      items: [
        { q: "What is a Module?",
          a: "A module groups related methods and constants together in one place, like a toolbox. Unlike a class, you can never write Module.new to make an object from it — modules exist purely to organize or share code, not to build things out of." },
        { q: "What is a Mixin?",
          a: "A \"mixin\" is just the name people use for a module once you include it inside a class. Doing that instantly gives every object made from that class access to all of the module's methods, as if you had written them directly inside the class yourself." },
        { q: "What's the difference between include and extend?",
          a: "include adds a module's methods as regular methods that every object of the class can call. extend instead adds them directly onto whatever you extend — usually the class itself — which turns them into class-level methods instead of object-level ones." },
        { q: "What is a Namespace?",
          a: "When two classes both want the same short name (like Order), wrapping each one inside its own module keeps them from colliding with each other. You then reach each specific one using ::, like Shop::Order versus Warehouse::Order." }
      ]
    },
    {
      day: 5,
      title: "OOP: inheritance vs composition",
      path: :day5_path,
      items: [
        { q: "What is inheritance?",
          a: "One class (class Dog < Animal) automatically gets all of another class's methods, without rewriting them. It represents an \"is-a\" relationship — a Dog IS an Animal, so it can do everything an Animal can do, plus its own extra stuff." },
        { q: "What is composition?",
          a: "Instead of inheriting from another class, a class simply holds an object of that other class inside it and uses it. It represents a \"has-a\" relationship — a Car HAS an Engine, but a Car is not itself a type of Engine." },
        { q: "What does super do?",
          a: "Inside a method that overrides a parent class's method, calling super runs the parent's original version of that same method right there. This lets you add extra behavior on top of the parent's, instead of throwing it away completely." },
        { q: "Inheritance or composition — which is better?",
          a: "Composition is usually more flexible, because swapping out one part (like plugging in a new Engine) is much easier than reshaping an entire chain of parent and child classes. That's why many experienced developers repeat the saying \"favor composition over inheritance.\"" }
      ]
    },
    {
      day: 6,
      title: "Enumerable (map, select, reduce, etc.)",
      path: :day6_path,
      items: [
        { q: "What does map do?",
          a: "It goes through every item in a list, transforms each one using the code you give it, and hands you back a brand new list of the exact same length. Example: [1, 2, 3].map { |n| n * 2 } => [2, 4, 6]." },
        { q: "What does select do?",
          a: "It goes through every item and keeps only the ones that pass a test you give it, throwing away the rest. Example: [1, 2, 3, 4].select { |n| n.even? } => [2, 4]. reject does the exact opposite — it keeps whatever fails the test." },
        { q: "What does reduce (also called inject) do?",
          a: "It walks through every item and folds them all down into one single final value, like a running total that keeps growing as it goes. Example: [1, 2, 3, 4].reduce(0) { |sum, n| sum + n } => 10." },
        { q: "What's the difference between map and each?",
          a: "each just walks through a list and runs your code for every item, but always hands you back the exact same original list, unchanged. map also walks through, but replaces every item with whatever your code returns for it." },
        { q: "Can you chain these methods together?",
          a: "Yes — since select and map both hand back a brand new array, you can call another Enumerable method right after. numbers.select(&:even?).map { |n| n * 10 } first filters the list down, then transforms whatever is left." }
      ]
    },
    {
      day: 7,
      title: "Review + build a small CLI app",
      path: :day7_path,
      items: [
        { q: "What's the point of a \"review day\"?",
          a: "It's not a new concept — it's taking everything from Days 1-6 (classes, modules, blocks, Enumerable) and combining them into one small real program, so you see how they actually work together instead of sitting in isolation." },
        { q: "What is a CLI app?",
          a: "A Command Line Interface app — a program you run and talk to entirely through typed text in a terminal, instead of clicking buttons in a browser or app window." },
        { q: "How do real CLI apps read what you type?",
          a: "Usually with a loop that keeps the program running, plus gets.chomp to read one line of text you typed and strip off the invisible newline character at the end of it." },
        { q: "Why build something small like a task manager to practice?",
          a: "A small project forces you to actually use classes, modules, and Enumerable methods together to solve a real problem — that sticks in your memory far better than just reading definitions." }
      ]
    },
    {
      day: 8,
      title: "Exception handling",
      path: :day8_path,
      items: [
        { q: "What does begin/rescue do?",
          a: "It lets you run some risky code inside begin, and if it raises an error, rescue catches it and runs your own recovery code instead of letting the whole program crash." },
        { q: "What does raise do?",
          a: "It lets you create and throw your own error on purpose, with a custom message, at the exact moment your code decides something shouldn't be allowed to continue." },
        { q: "What is a custom exception class?",
          a: "Your own named error type, made by inheriting from StandardError, like class InsufficientFundsError < StandardError. This lets you rescue that exact kind of problem specifically, instead of treating every possible error the same way." },
        { q: "What does ensure do?",
          a: "It marks a block of code that always runs no matter what happens — whether everything succeeded, or an error got raised and rescued. It's normally used for cleanup, like closing a file or a connection." }
      ]
    },
    {
      day: 9,
      title: "File I/O and JSON",
      path: :day9_path,
      items: [
        { q: "How do you write to a file in Ruby?",
          a: "File.write(\"notes.txt\", \"some text\") creates the file if it doesn't exist yet, or overwrites it if it does, and puts your text inside." },
        { q: "How do you read a file back?",
          a: "File.read(\"notes.txt\") opens the file and hands you back its entire contents as one big string. File.exist?(\"notes.txt\") lets you check first whether the file is even there." },
        { q: "What is JSON, and how do you make it from Ruby data?",
          a: "JSON is just a text format for representing data (like a hash) that almost every programming language understands. Calling .to_json on a Ruby hash or array converts it into that text format." },
        { q: "How do you turn JSON text back into Ruby data?",
          a: "JSON.parse(json_text) does it. By default the resulting hash's keys come back as Strings, not Symbols — pass JSON.parse(json_text, symbolize_names: true) if you want Symbol keys instead." }
      ]
    },
    {
      day: 10,
      title: "Symbols vs Strings, memory basics",
      path: :day10_path,
      items: [
        { q: "What's the actual difference between a Symbol and a String?",
          a: "They can look almost identical (:name vs \"name\"), but a String holds real text data you're free to change, while a Symbol works more like a fixed, permanent label that Ruby reuses everywhere it appears." },
        { q: "What does it mean that symbols are \"the same object\"?",
          a: "Every time you write :name anywhere in your program, Ruby points to the exact same object in memory. Every time you write \"name\", Ruby creates a brand new String object, even though the text looks identical." },
        { q: "Can you change a Symbol like you can a String?",
          a: "No. Strings are mutable — you can change their contents in place with things like <<. Symbols are always frozen — they're built to stay fixed, so there's no way to change one." },
        { q: "Why do Rails and Ruby programs use symbols as hash keys so often?",
          a: "Since every :key is the exact same reused object, comparing keys is faster and uses less memory than comparing separate String objects that merely look the same — and that adds up fast in a program doing lots of hash lookups." }
      ]
    }
  ].freeze

  def index
    @questions_by_day = QUESTIONS
  end

  def day1
    cat = Day1Examples::Animal.new("Cat", "Meow")
    dog = Day1Examples::Animal.new("Dog", "Woof")
    @animal_output = [cat.speak, dog.speak]

    self_demo = Day1Examples::SelfDemo.new
    @self_instance_output = self_demo.instance_method_self
    @self_class_output = Day1Examples::SelfDemo.class_method_self

    @object_model_output = [
      "5.class => #{5.class}",
      "\"hello\".class => #{"hello".class}",
      "nil.class => #{nil.class}",
      "true.class => #{true.class}",
      "Day1Examples::Animal.class => #{Day1Examples::Animal.class}",
      "Day1Examples::Animal.superclass => #{Day1Examples::Animal.superclass}"
    ]

    book = Day1Examples::Book.new("Ruby Basics")
    @attr_before = book.title
    book.title = "Advanced Ruby"
    @attr_after = book.title
  end

  def day2
    @default_arg_output = Day2Examples.order_coffee
    @custom_arg_output = Day2Examples.order_coffee("Large")

    @no_toppings_output = Day2Examples.add_toppings
    @with_toppings_output = Day2Examples.add_toppings("milk", "sugar")

    @keyword_default_output = Day2Examples.order_details(size: "Large")
    @keyword_custom_output = Day2Examples.order_details(size: "Large", sugar: 3)

    @block_output = Day2Examples.make_coffee { "extra hot, no foam" }
    @no_block_output = Day2Examples.make_coffee

    @explicit_block_output = Day2Examples.make_coffee_n_times(3) { |cup| "Cup ##{cup} ready!" }
  end

  def day3
    add_proc = Day3Examples.add_with_proc
    add_lambda = Day3Examples.add_with_lambda

    @add_proc_output = add_proc.call(2, 3)
    @add_lambda_output = add_lambda.call(2, 3)
    @square_output = Day3Examples.square(4)

    @proc_is_lambda = add_proc.lambda?
    @lambda_is_lambda = add_lambda.lambda?

    @lambda_missing_arg_output = Day3Examples.call_lambda_with_missing_argument
    @proc_missing_arg_output = Day3Examples.call_proc_with_missing_argument

    @proc_return_output = Day3Examples.proc_stops_the_whole_method
    @lambda_return_output = Day3Examples.lambda_only_stops_itself
  end

  def day4
    @module_output = Day4Examples::MathHelpers.square(4)

    person = Day4Examples::Person.new("Ali")
    @mixin_output = person.greet

    @include_output = Day4Examples::Bird.new.fly
    @extend_output = Day4Examples::Robot.fly

    shop_order = Day4Examples::Shop::Order.new
    warehouse_order = Day4Examples::Warehouse::Order.new
    @namespace_output = [shop_order.summary, warehouse_order.summary]
  end

  def day5
    dog = Day5Examples::Dog.new("Rex")
    @inherit_eat_output = dog.eat
    @inherit_bark_output = dog.bark
    @dog_is_animal = dog.is_a?(Day5Examples::Animal)

    @super_output = Day5Examples::LoudDog.new("Rex").eat

    car = Day5Examples::Car.new
    @composition_output = car.start
    @car_is_engine = car.is_a?(Day5Examples::Engine)
  end

  def day6
    small_numbers = [1, 2, 3, 4]
    bigger_numbers = [1, 2, 3, 4, 5, 6]

    @map_output = Day6Examples.double_all(small_numbers)

    @select_output = Day6Examples.keep_evens(bigger_numbers)
    @reject_output = Day6Examples.remove_evens(bigger_numbers)

    @reduce_output = Day6Examples.sum_all(small_numbers)

    @find_output = Day6Examples.first_greater_than(bigger_numbers, 3)
    @sort_output = Day6Examples.sorted([3, 1, 2])
    @chained_output = Day6Examples.evens_times_ten_summed(bigger_numbers)
  end

  def day7
    manager = Day7Examples::TaskManager.new
    @session_log = []
    @session_log << manager.add("Learn Ruby")
    @session_log << manager.add("Build a CLI app")
    @session_log << manager.add("Review Enumerable methods")
    @session_log << manager.complete(0)

    @task_list_output = manager.list
    @pending_count_output = manager.pending_count
  end

  def day8
    @divide_ok_output = Day8Examples.safe_divide(10, 2)
    @divide_error_output = Day8Examples.safe_divide(10, 0)

    @age_ok_output = Day8Examples.check_age_safely(25)
    @age_error_output = Day8Examples.check_age_safely(-5)

    @withdraw_ok_output = Day8Examples.withdraw_safely(100, 40)
    @withdraw_error_output = Day8Examples.withdraw_safely(100, 500)

    @ensure_success_log = Day8Examples.process_with_ensure(false)
    @ensure_failure_log = Day8Examples.process_with_ensure(true)
  end

  def day9
    file_result = Day9Examples.write_and_read_file
    @file_existed_output = file_result[:existed]
    @file_content_output = file_result[:content]

    @json_text_output = Day9Examples.ruby_to_json
    @json_string_keys_output = Day9Examples.json_to_ruby_with_string_keys
    @json_symbol_keys_output = Day9Examples.json_to_ruby_with_symbol_keys

    @saved_and_loaded_output = Day9Examples.save_and_load_json
  end

  def day10
    @symbol_class_output = Day10Examples.symbol_class
    @string_class_output = Day10Examples.string_class

    @same_symbol_ids_output = Day10Examples.same_symbol_same_object
    @different_string_ids_output = Day10Examples.different_string_different_object

    @mutated_string_output = Day10Examples.mutate_a_string
    @symbol_frozen_output = Day10Examples.try_mutate_a_symbol

    @hash_output = Day10Examples.hash_with_symbol_keys
  end
end
