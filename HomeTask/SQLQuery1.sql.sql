SELECT  p.BusinessEntityID
FROM Person.Person AS p
INTERSECT/*???? ??? ? ? ??????? ????????????? ?????
expect ???? ??? ???????? ? ??????? ????????????? ??????*/
SELECT  ea.BusinessEntityID
FROM Person.EmailAddress AS ea