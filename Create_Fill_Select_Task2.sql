--Create simple tables with many-to-many rel
CREATE TABLE Tag(
    TagID INT IDENTITY(1,1) PRIMARY KEY, 
    Name varchar(30)
);

CREATE TABLE Article(
    ArticleID INT IDENTITY(1,1) PRIMARY KEY, 
    Title varchar(30)
);  

CREATE TABLE Tags_Articles(
    TagID INT NOT NULL,
    ArticleID INT NOT NULL,
    FOREIGN KEY (ArticleID) REFERENCES Article(ArticleID), 
    FOREIGN KEY (TagID) REFERENCES Tag(TagID),
    UNIQUE (TagID, ArticleID)
);
GO

--Fill Tag and Article table
DECLARE @cnt INT = 0;

WHILE @cnt < 10
BEGIN
   INSERT INTO TAG(Name) VALUES ('Name'+CONVERT(varchar(10), @cnt))
   INSERT INTO Article(Title) VALUES ('Title'+CONVERT(varchar(10), @cnt))
   SET @cnt = @cnt + 1;
END;
GO

-- Fill many-to-many relationship table with 5 values
DECLARE @cnt INT = 0;

WHILE @cnt < 5
BEGIN
	INSERT INTO Tags_Articles(TagID,ArticleID) VALUES (@cnt,@cnt);
   SET @cnt = @cnt + 1;
END;
GO

--Select by assignment
SELECT 
	t.Name as 'Tag Name',
	a.Title as 'Article Title'
	FROM Tag t
	LEFT JOIN Tags_Articles ta on t.TagID = ta.TagID
	LEFT JOIN Article a on ta.ArticleID = a.ArticleID
