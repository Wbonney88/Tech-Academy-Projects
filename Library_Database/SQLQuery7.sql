USE Library
GO

SELECT B.Title, A.AuthorName, C.NO_Of_Copies, L.BranchName
FROM Book AS B
INNER JOIN Book_AUTHORS AS A
ON B.Bookid = A.Bookid
INNER JOIN BOOK_COPIES AS C
ON B.Bookid = C.Bookid
INNER JOIN LIBRARY_BRANCH AS L
ON C.Branchid = L.Branchid
WHERE L.Branchid = 1 AND A.AuthorName LIKE '%Stephen King%'