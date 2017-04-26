USE Library
GO

SELECT B.BranchName, COUNT(L.Branchid) AS #OnLoan
 FROM LIBRARY_BRANCH AS B
 INNER JOIN BOOK_LOANS AS L
 ON B.Branchid = L.Branchid
 GROUP BY B.BranchName