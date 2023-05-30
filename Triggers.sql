use Movies321;
-- vaild movie trigger 
CREATE TRIGGER validate_movie_insert
ON Movies
INSTEAD OF INSERT
AS
BEGIN
    -- Check if the inserted category ID exists in the Catagories table
    IF NOT EXISTS (SELECT 1 FROM Catagories WHERE CatergoryID IN (SELECT CatergoryID FROM inserted))
    BEGIN
        RAISERROR ('Invalid category ID. Insertion into Movies table failed.', 16, 1)
        RETURN;
    END

    -- Check if the inserted director ID exists in the Directors table
    IF NOT EXISTS (SELECT 1 FROM Directors WHERE DirectorID IN (SELECT DirectorID FROM inserted))
    BEGIN
        RAISERROR ('Invalid director ID. Insertion into Movies table failed.', 16, 1)
        RETURN;
    END

    -- Check if the movie already exists in the Movies table
    IF EXISTS (SELECT 1 FROM Movies WHERE MovieID IN (SELECT MovieID FROM inserted))
    BEGIN
        RAISERROR ('Movie already exists. Insertion into Movies table failed.', 16, 1)
        RETURN;
    END

    -- Check if the ImageName ends with ".jpeg"
    IF NOT EXISTS (SELECT 1 FROM inserted WHERE ImageName LIKE '%.jpeg')
    BEGIN
        RAISERROR ('Invalid ImageName format. Insertion into Movies table failed.', 16, 1)
        RETURN;
    END

    -- Insert the valid rows into the Movies table
    INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLInk, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName)
    SELECT MovieID, MovieTitle, Runtime, Release_Year, TrailerLInk, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName
    FROM inserted;
END;


--vaild admin 
CREATE TRIGGER generate_admin_password
ON Admin
AFTER INSERT
AS
BEGIN
    DECLARE @AdminID INT, @Password NVARCHAR(50), @Lname VARCHAR(50), @Fname VARCHAR(50), @Email NVARCHAR(50);

    SELECT @AdminID = AdminID,
           @Lname = Lname,
           @Fname = Fname,
           @Email = Email
    FROM inserted;

    -- Generate a random password using NEWID() and convert it to a string
    SET @Password = CONVERT(NVARCHAR(50), NEWID());

    -- Update the inserted record with the generated password
    UPDATE Admin SET Password = @Password WHERE AdminID = @AdminID;

    -- Print out the generated password
    PRINT 'Generated Password for Admin ID ' + CAST(@AdminID AS NVARCHAR(50)) + ': ' + @Password;
END;

--genorates watchlist id
CREATE TRIGGER generate_watchlist_id
ON Watchlist
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaxListtID INT;
    SELECT @MaxListtID = ISNULL(MAX(ListtID), 0) FROM Watchlist;

    INSERT INTO Watchlist (ListtID, Userid, MovieID)
    SELECT @MaxListtID + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), Userid, MovieID
    FROM inserted;
END;


--Checkpayment details
CREATE TRIGGER check_payment_details_fk
ON Users
INSTEAD OF UPDATE
AS
BEGIN
    IF UPDATE(SubID)
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM inserted i
            WHERE i.UserId IN (SELECT UserId FROM Payment_details)
        )
        BEGIN
            UPDATE u
            SET u.SubID = i.SubID
            FROM Users u
            INNER JOIN inserted i ON u.UserId = i.UserId;
        END
        ELSE
        BEGIN
			RAISERROR ('Cannot update SubID. UserID exists in Payment_details table.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
    END
END;






