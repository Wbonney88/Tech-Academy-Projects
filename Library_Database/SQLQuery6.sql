USE Library
GO

SELECT B.Name, B.[Address], COUNT(L.CardNO) AS #OfBooksOut
FROM BORROWER AS B
INNER JOIN BOOK_LOANS AS L
ON B.CardNo = L.CardNo
GROUP BY B.Name, B.[Address]
HAVING COUNT(L.CardNo) >= 5
