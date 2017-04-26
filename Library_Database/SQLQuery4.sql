USE Library
GO

DECLARE @CurrentDate AS DATE

SET @CurrentDate = GETDATE()

SELECT B.Title, BR.Name, BR.[Address]
FROM Book AS B INNER JOIN Book_loans AS L
ON B.Bookid = L.Bookid
INNER JOIN BORROWER AS BR
ON BR.CardNo = L.CardNo
WHERE L.Branchid = 2 
AND L.DueDate = @CurrentDate
