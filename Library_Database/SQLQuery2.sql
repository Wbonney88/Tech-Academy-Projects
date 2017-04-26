USE Library
GO

SELECT B.Title, L.BranchName, C.No_of_Copies 
FROM BOOK_COPIES AS C INNER JOIN LIBRARY_BRANCH AS L
ON C.Branchid = L.Branchid
INNER JOIN Book AS B
ON C.Bookid = B.Bookid
WHERE C.Bookid = 1 