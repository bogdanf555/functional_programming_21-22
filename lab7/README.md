# Answers for Lab 7

## Exercise 7.1.1

Add a button with the text **Create account** that is disabled if the password or username
fields are empty. You don’t have to add the **onClick** attribute to the button.

**Response:** added the disabled attribute to the button with the proper condition (isNotComplete function in Inputs.elm)

## Exercise 7.1.2

Add a new input field where the user has to repeat their password, to ensure that the
password matches. Display a green success message if the passwords match or red error
message if the passwords are different. The submit button should also be disabled if the
passwords don’t match.

**Response:** added the confirm password field and implemented the necessary logic in Inputs.elm

## Exercise 7.1.3

If the account is for administrators (has type Admin ), the password must have at least
12 characters. For regular users it must have at least 8 characters.
Display an error message and disable the submit button if the password doesn’t meet the
specified criteria.

**Response:** added the necessary logic in Inputs.elm in functions: **conditions** and **isNotComplete**

## Exercise 7.6.1

Run the tails function to check if it behaves according to the examples. If not, find
and fix the bug.

**Reponse:** I modified the function this way and the example passes.

```elm
tails : List a -> List (List a)
tails l =
    case l of
        [] -> []::[]
        x::xs -> (x::xs)::tails xs
```

## Exercise 7.6.2

Implement the combinations function such that the tests pass.

**Response:**
```elm
combinations : List a -> List (List a)
combinations l = 
    case l of
        [] -> [[]]
        x::xs -> 
            let
                tailList = combinations xs
            in
            (List.append (List.map (\a -> List.append ([x]) a) tailList) tailList)
```

## Exercise 7.6.3

Display the population and population density (population/area) for each country.

**Response:** updated the Countries.elm to display this two attributes of a country.

## Exercise 7.6.4

Sort the countries by area in descending order.

**Response:**

```elm

countryComparison a b =
    case compare a.area b.area of
      LT -> GT
      EQ -> EQ
      GT -> LT

List.sortWith countryComparison countries
```

## Exercise 7.6.5

Add a checkbox which allows the user to change the current sort order of countries to
ascending (i.e. if the checkbox is is unchecked the sort order will be descending, if it
checked the sort order will be ascending).

**Response:** Added another field in the Success model called sorting which retains if it is ascending
or decending and changes it in an event called ChangeSorting.


## Exercise 7.6.6

Add a dropdown list (select element) to select the field for the sorting. The options
should be: population, area, population density

**Response:** Added another field in the Success model which keeps track of the field which has
to be compared in order to sort the countries and changed the comparing function to support the 
variable of the "compare by" field.