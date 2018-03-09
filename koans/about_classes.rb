require File.expand_path(File.dirname(__FILE__) + '/neo')

# Variables in a Ruby Class
# Ruby provides four types of variables −
#
# Local Variables − Local variables are the variables that are defined in a method.
# Local variables are not available outside the method.
# You will see more details about method in subsequent chapter.
# Local variables begin with a lowercase letter or _.
#
# Instance Variables − Instance variables are available across methods for any particular instance or object.
# That means that instance variables change from object to object.
# Instance variables are preceded by the at sign (@) followed by the variable name.
#
# Class Variables − Class variables are available across different objects.
# A class variable belongs to the class and is a characteristic of a class.
# They are preceded by the sign @@ and are followed by the variable name.
#
# Global Variables − Class variables are not available across classes.
# If you want to have a single variable, which is available across classes,
# you need to define a global variable.
# The global variables are always preceded by the dollar sign ($).

class AboutClasses < Neo::Koan
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new
    fido = Dog.new
    assert_equal AboutClasses::Dog, fido.class
  end

  # ------------------------------------------------------------------

  class Dog2
    def set_name(a_name)
      @name = a_name
    end
  end

  def test_instance_variables_can_be_set_by_assigning_to_them
    fido = Dog2.new
    assert_equal [], fido.instance_variables

    fido.set_name("Fido")
    assert_equal [:@name], fido.instance_variables
  end

  def test_instance_variables_cannot_be_accessed_outside_the_class
    fido = Dog2.new
    fido.set_name("Fido")

    assert_raise(NoMethodError) do
      fido.name
    end

    assert_raise(SyntaxError) do
      eval "fido.@name"
      # NOTE: Using eval because the above line is a syntax error.
    end
  end

  def test_you_can_politely_ask_for_instance_variable_values
    fido = Dog2.new
    fido.set_name("Fido")

    assert_equal 'Fido', fido.instance_variable_get("@name")
  end

  def test_you_can_rip_the_value_out_using_instance_eval
    fido = Dog2.new
    fido.set_name("Fido")

    assert_equal 'Fido', fido.instance_eval("@name")  # string version
    assert_equal 'Fido', fido.instance_eval { @name } # block version
  end

  # ------------------------------------------------------------------

  class Dog3
    def set_name(a_name)
      @name = a_name
    end
    def name
      @name
    end
  end

  def test_you_can_create_accessor_methods_to_return_instance_variables
    fido = Dog3.new
    fido.set_name("Fido")

    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

  class Dog4
    attr_reader :name

    def set_name(a_name)
      @name = a_name
    end
  end


  def test_attr_reader_will_automatically_define_an_accessor
    fido = Dog4.new
    fido.set_name("Fido")

    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

  class Dog5
    attr_accessor :name
  end


  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors
    fido = Dog5.new

    fido.name = "Fido"
    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

  class Dog6
    attr_reader :name
    def initialize(initial_name)
      @name = initial_name
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables
    fido = Dog6.new("Fido")
    assert_equal 'Fido', fido.name
  end

  def test_args_to_new_must_match_initialize
    assert_raise(ArgumentError) do
      Dog6.new
    end
    # THINK ABOUT IT:
    # Why is this so?
    #
    # The initialize method has a required argument of initial_name.
    # If it had a default value then no error would occur.
  end

  def test_different_objects_have_different_instance_variables
    fido = Dog6.new("Fido")
    rover = Dog6.new("Rover")

    assert_equal true, rover.name != fido.name
  end

  # ------------------------------------------------------------------

  class Dog7
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end

    # self is a reserved keyword in Ruby that always refers to an object,
    # but the object self refers to frequently changes based on the context.
    # When methods are called without an explicit receiver,
    # Ruby sends the message to the object assigned to the self keyword.

    def get_self
      self
    end

    def to_s
      @name
    end

    def inspect
      "<Dog named '#{name}'>"
    end
  end

  def test_inside_a_method_self_refers_to_the_containing_object
    fido = Dog7.new("Fido")

    fidos_self = fido.get_self
    assert_equal fidos_self, fidos_self
  end

  def test_to_s_provides_a_string_version_of_the_object
    fido = Dog7.new("Fido")
    assert_equal 'Fido', fido.to_s
  end

  def test_to_s_is_used_in_string_interpolation
    fido = Dog7.new("Fido")
    assert_equal 'My dog is Fido', "My dog is #{fido}"
  end

  def test_inspect_provides_a_more_complete_string_version
    fido = Dog7.new("Fido")
    assert_equal "<Dog named 'Fido'>", fido.inspect
  end

  def test_all_objects_support_to_s_and_inspect
    array = [1,2,3]

    assert_equal "[1, 2, 3]", array.to_s
    assert_equal "[1, 2, 3]", array.inspect

    assert_equal "STRING", "STRING".to_s
    assert_equal "\"STRING\"", "STRING".inspect
  end

end