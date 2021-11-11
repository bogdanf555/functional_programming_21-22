# Answers to lab questions

## Exercise 6.2.1

Starting from the code above and the type definition for **Recipe** , write a function
**recipeView : Recipe -> Html msg** that can render any recipe (i.e. avoid hardcoding the
recipe data into the view)

**Respose:** The solution can be find in RecipeView.elm; I basically mapped a list of li for ingredients
and one of p for methods.

## Exercise 6.2.2

Modify the Counter app to prevent the counter from going over 10 or under -10 by
disabling the + or - buttons when the value is reached.
Remove the call to **skip** in the CounterTests.elm file to test your implementation.

**Response:** implementation in button attributes in Counter.elm

## Exercise 6.2.3

Modify the Counter app to make the text red when the counter is close (is greater than
8 or less than -8) to 10 or -10.

**Response:** I implemented the function which returns a a color style attribute:

```elm
colorAttribute : Model -> Html.Attribute msg
colorAttribute model = 
  let
    greenColor = style "color" "green"
    redColor = style "color" "red"
  in
    if model < -8 || model > 8 then
      redColor
    else
      greenColor
```

## Exercise 6.4.1

Write a test for the coin flip app to test that the initial view contains the text “Press the
flip button to get started”.

**Response:** the test can be fount in CoinFlipTest.elm with name **initialViewTest**

## Exercise 6.4.2

Change your solution to Exercise 6.2.1 by adding the ingredient class to
the view for each ingredient, such that the **atLeastOneIngredientClass** and
**eachIngredientHasClassIngredient** both pass.

**Respose:** added (class "ingredient") to each list item in the generated unordered list for ingredients

# 6.5 Review questions

## Question 6.5.1

What are the 3 components of the Elm Architecture?

**Respose:** model - view - update

## Question 6.5.2

What is the fundamental difference between a command and a message?

**Respose:** To build interactive apps we will always need to use messages in order to update the view,
but we do not need necessarilly to use commands if we do not need side effects for our application.
The recipient of a message is the update method implemented by use. The recipient of the command is
the Elm Runtime.

## Question 6.5.3

Which are the two steps of a command?

**Response:** First step is the task itself (api call, browser/sys calls) which when is completed it
triggers the second steps which is calling the update function with the generated model.

# 6.6 Practice problems

## Exercise 6.6.1

Modify the Coin flip app to display the number of heads and tails outcomes so far, in
two ways:
1. Keep the number in the Model and simply display it in the view
**Response:** it seems that if we implement it with variable it always an update back
2. Compute the values from the flips field of the Model each time in the view
**Response:** because we compute it in the view on the current model it updates properly

**Response:** solution in CoinFlip.elm (changed the model, the update function and the view function)

## Exercise 6.6.2

Modify the Coin flip app to have an initial flip (i.e. when the user loads the app, it should
initially display heads or tails instead of current message).

Try to answer the following questions before writing the code:
1. What function will you modify to solve this problem?
**Reponse:** the init function we simply add the command: Random.generate AddFlip coinFlip
2. Can you make the Model simpler after making this change?
**Response:** We can modify the currentFlip variable type from Maybe CoinSide to simply CoinSide
since there will always be a coin flip from the beginnning.

**Response:** solution in CoinFlip.elm (changed the init function)

## Exercise 6.6.3

Add a “Flip 10” and a “Flip 100” button to the Coin flip app that triggers 10 and 100
coin flips respectively.

**Response:** I used the tricy implementation suggested in the lab text:
By using the Cmd.batch function. Hacky for this particular problem, but you don’t
need to change the logic in other places.

I added a new type of msg: (FlipMultiple Int) which I call respectively with 10 and 100.
