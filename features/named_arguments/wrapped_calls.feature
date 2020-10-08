@php8
Feature: Named arguments in wrapped calls

  Named arguments are introduced in PHP 8, and we need to support them for result wrapping

  Scenario: Named argument in class method
    Given the class file 'src/NamedArgs/ClassMethod.php' contains:
       """
       <?php

       namespace NamedArgs;

       class ClassMethod
       {
           function foo($baz = null, $bar = null) {
               return $bar;
           }
       }
      """
    And the spec file "spec/NamedArgs/ClassMethodSpec.php" contains:
      """
      <?php

      namespace spec\NamedArgs;

      use PhpSpec\ObjectBehavior;

      class ClassMethodSpec extends ObjectBehavior
      {
          function it_returns_bar_from_foo()
          {
              $this->foo(bar: 2)->shouldReturn(2);
          }
      }
      """
    When I run phpspec
    Then the suite should pass

  Scenario: Named argument in class method
    Given the class file 'src/NamedArgs/ResultMethod.php' contains:
       """
       <?php

       namespace NamedArgs;

       class ResultMethod
       {
           function foo() {

               return new class() {
                   function bar ($baz = null, $bar = null) {
                       return $bar;
                   }
               };
           }
       }
      """
    And the spec file "spec/NamedArgs/ResultMethodSpec.php" contains:
      """
      <?php

      namespace spec\NamedArgs;

      use PhpSpec\ObjectBehavior;

      class ResultMethodSpec extends ObjectBehavior
      {
          function it_returns_bar_from_foo()
          {
              $this->foo()->bar(bar: 3)->shouldReturn(3);
          }
      }
      """
    When I run phpspec
    Then the suite should pass

