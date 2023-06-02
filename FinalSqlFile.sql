--Create the database 
CREATE DATABASE Movies321;
go
USE Movies321;
go
--Create the tables 
CREATE TABLE [Payment_details] (
  [PaymentID] Varchar(50),
  [CardNumber] varchar(50),
  [ExpDate] varchar(50),
  [CSV] int,
  [UserID] Varchar(50),
  PRIMARY KEY ([PaymentID])
);
go
CREATE TABLE [Catagories] (
  [CatergoryID] int,
  [Name] varchar(50),
  PRIMARY KEY ([CatergoryID])
);
go
CREATE TABLE [Subscription_level] (
  [Sub_ID] int,
  [Name] varchar(20),
  [Price] Float,
  PRIMARY KEY ([Sub_ID])
);
go
CREATE TABLE [Directors] (
  [DirectorID] int,
  [DirectorFName] varchar(50),
  [DirectorLName] varchar(50),
  PRIMARY KEY ([DirectorID])
);
go
CREATE TABLE [Movies] (
  [MovieID] varchar(10),
  [MovieTitle] varchar(50),
  [Runtime] time,
  [Release_Year] date,
  [TrailerLInk] varchar(50),
  [Ratings] varchar(10),
  [AgeRating] int,
  [ShortDiscription] varchar(300),
  [CatergoryID] int,
  [DirectorID] int,
  [SubID] int,
  [Views] int,
  [ImageName] varchar(100),
  PRIMARY KEY ([MovieID]),
  CONSTRAINT [FK_Movies.SubID]
    FOREIGN KEY ([SubID])
      REFERENCES [Subscription_level]([Sub_ID]),
  CONSTRAINT [FK_Movies.DirectorID]
    FOREIGN KEY ([DirectorID])
      REFERENCES [Directors]([DirectorID])
);
go
CREATE TABLE [Users] (
  [UserId] varchar(50),
  [Password] varchar(100),
  [Email] nvarchar(50),
  [Fname] varchar(50),
  [Lname] varchar(50),
  [SubID] int,
  [User_DOB] Date,
  [Datelastpaid] Date,
  PRIMARY KEY ([UserId]),
  CONSTRAINT [FK_Users.SubID]
    FOREIGN KEY ([SubID])
      REFERENCES [Subscription_level]([Sub_ID])
);
go
CREATE TABLE [Watchlist] (
  [ListtID] int,
  [Userid] varchar(50),
  [MovieID] varchar(10),
  PRIMARY KEY ([ListtID]),
  CONSTRAINT [FK_Watchlist.MovieID]
    FOREIGN KEY ([MovieID])
      REFERENCES [Movies]([MovieID]),
  CONSTRAINT [FK_Watchlist.Userid]
    FOREIGN KEY ([Userid])
      REFERENCES [Users]([UserId])
);
go
CREATE TABLE [Admin] (
  [AdminID] Int,
  [Fname] varchar(50),
  [Lname] varchar(50),
  [email] nvarchar(50),
  [Password] varchar(50),
  PRIMARY KEY ([AdminID])
);
go
CREATE TABLE [Invoices] (
  [InvoiceID] int,
  [Date] Date,
  [PayBy] Date,
  [UserID] Varchar(50),
  PRIMARY KEY ([InvoiceID]),
  CONSTRAINT [FK_Invoices.InvoiceID]
    FOREIGN KEY ([UserID])
      REFERENCES [Users]([UserId])
);
go
--Triggers run this 2ed 
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
go
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
go
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
go
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
go
--Procedures
--Updates veiws  
Create procedure UpdateViews
@Movie_title varchar(50)
As
Update Movies 
Set Views = Views + 1
where MovieTitle = @Movie_title;
go
--addmin sign in
create procedure adminSignIn_st
@email varchar(100),
@Password varchar(1000)
as
select * from Admin where email = @email and Password = @Password;
go
--Add admin
create procedure adminSignUp_st(
@AdminID Int,
@Fname varchar(100),
@Lname varchar(100),
@email varchar(100),
@Password varchar(100))
as 
insert into Admin values(@AdminID, @Fname, @Lname, @email, @Password);
go
--Addusers
create procedure userSignUp_st(
 @UserId varchar(100),
 @Password varchar(max),
 @Email varchar(100),
 @Fname varchar(100),
 @Lname varchar(100),
 @SubID int,
 @User_DOB Date,
 @Datelastpaid Date)
as
insert into Users values(@UserId,@Password, @Email, @Fname, @Lname, @SubID, @User_DOB, @Datelastpaid);
go
--Add Payment method
create procedure AddUserPayments_st(
@PaymentId varchar(100),
@cardNumber varchar(20),
@ExpDate varchar(10),
@CVV int,
@UserID varchar(100))
as 
insert into Payment_details values (@PaymentId, @cardNumber, @ExpDate, @CVV, @UserID);
go
--User watchlist
Create procedure seeWatchlist
@userid varchar(50)
AS
SELECT u.Fname, m.MovieTitle, m.ShortDiscription
FROM Watchlist w
inner join Movies m
on m.MovieID = w.MovieID
inner join users u
on u.UserId = w.Userid
where w.Userid = @userid
go
--Update user
Create procedure UpdateUser
@fname varchar(50),
@lname varchar(50),
@email varchar(50),
@password varchar(50)
AS
if @fname is not null
begin
 Update Users 
 set Fname = @fname
 end
 if @lname is not null
begin
 Update Users 
 set Lname = @lname
 end
 if @email is not null
begin
 Update Users 
 set Email = @email
 end
 if @password is not null
begin
 Update Users 
 set Password = @password
 end
 go
 --Add to watch list
 Create procedure AddtoWatchList
 @userid varchar(50),
 @movieId varchar(50)
 AS
 Insert into Watchlist (Userid,MovieID) Values(@userid,@movieid)
 go
 --Update raiting 
 CREATE PROCEDURE Updaterating
 @movieid varchar(50),
 @Rateing int
 AS
 Update Movies
 set Ratings = ((Ratings * Views) + @Rateing)/Views
 where MovieTitle = @movieid;
 go
 --Get user subscription id
 Create procedure Getusersubid
 @username varchar(50)
 AS
 SELECT SubID from Users where Email = @username
 go
 --Inserts 
 --Directors inserts
INSERT INTO Directors  VALUES
(1, 'Steven', 'Spielberg'),
(2, 'Christopher', 'Nolan'),
(3, 'Quentin', 'Tarantino'),
(4, 'Martin', 'Scorsese'),
(5, 'James', 'Cameron'),
(6, 'Ridley', 'Scott'),
(7, 'David', 'Fincher'),
(8, 'Peter', 'Jackson');
go
INSERT INTO Directors  VALUES
(13, 'Roger', 'Allers'),
(14, 'Ridley', 'Scott'),
(15, 'David', 'Fincher'),
(16, 'Robert', 'Zemeckis'),
(17, 'Gabriele', 'Muccino'),
(18, 'Christopher', 'Nolan'),
(19, 'Baz', 'Luhrmann');
go
INSERT INTO Directors VALUES
(20, 'Brad', 'Bird'),
(21, 'Nick', 'Cassavetes'),
(22, 'Quentin', 'Tarantino'),
(23, 'M. Night', 'Shyamalan'),
(24, 'James', 'Cameron'),
(25, 'Jonathan', 'Demme'),
(26, 'Martin', 'Scorsese');
go
INSERT INTO Directors VALUES
(27, 'Joel', 'Coen'),
(28, 'Ethan', 'Coen'),
(29, 'Darren', 'Aronofsky'),
(30, 'Guy', 'Ritchie'),
(31, 'Peter', 'Jackson'),
(32, 'Alejandro', 'González Iñárritu'),
(33, 'Christopher', 'McQuarrie');
go
INSERT INTO Directors  VALUES
(34, 'Denis', 'Villeneuve'),
(35, 'David', 'Fincher'),
(36, 'Stanley', 'Kubrick'),
(37, 'Alfred', 'Hitchcock'),
(38, 'Tim', 'Burton'),
(39, 'Wes', 'Anderson'),
(40, 'Hayao', 'Miyazaki');
go
INSERT INTO Directors  VALUES
(9, 'Christopher', 'Nolan'),
(10, 'Quentin', 'Tarantino'),
(11, 'Martin', 'Scorsese'),
(12, 'Steven', 'Spielberg');
go
INSERT INTO Directors  VALUES
(41, 'Elizabeth','Banks'),
(42,'James','Gunn'),
(43, 'Jean-François','Ritchet'),
(44, 'David','Sandberg'),
(45, 'Rian','Johnson'),
(46, 'Gene','Stupnitsky'),
(47, 'Emer','Reynolds'),
(48, 'John','Hamburg'),
(49, 'Pierre','Perifel'),
(50, 'Yoni','Brenner'),
(51, 'Dean','Graig'),
(52, 'Patrick','Hughes'),
(53, 'Tommy','Wirkola'),
(54, 'David','Green'),
(55, 'Jeff','Wadlow'),
(56, 'Tom','McGrath'),
(57, 'Annemarie','van de Mond'),
(58, 'James','Birdman');
go
--Sub level inserts
INSERT INTO Subscription_level VALUES
(1, 'Basic', 0.00),
(2, 'Standard', 99.00),
(3, 'Premium', 199.00);
go
--catagorie inserts
INSERT INTO Catagories  VALUES
(1, 'Action'),
(2, 'Comedy'),
(3, 'Drama'),
(4, 'Thriller'),
(5, 'Horror'),
(6, 'Romance'),
(7, 'Science Fiction'),
(8, 'Documentary'),
(9, 'Kids');
go
--Insert movies
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('1', 'Jurassic Park', '02:07:00', '1993-01-01', 'https://www.youtube.com/watch?v=lc0UehYemQA', '8.1', 13, 'A pragmatic paleontologist visiting an almost complete theme park is tasked with protecting a couple of kids after a power failure causes the park''s cloned dinosaurs to run loose.', 1, 1, 1, 0, 'Jurassic Park.jpeg'),
('2', 'The Dark Knight', '02:32:00', '2008-01-01', 'https://www.youtube.com/watch?v=EXeTwQWrcwY', '9.0', 13, 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.', 1, 2, 2, 0, 'The Dark Knight.jpeg'),
('3', 'Pulp Fiction', '02:34:00', '1994-01-01', 'https://www.youtube.com/watch?v=s7EdQ4FqbhY', '8.9', 17, 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 3, 3, 3, 0, 'Pulp Fiction.jpeg'),
('4', 'The Departed', '02:31:00', '2006-01-01', 'https://www.youtube.com/watch?v=iojhqm0JTW4', '8.5', 17, 'An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston.', 3, 4, 2, 0, 'The Departed.jpeg'),
('5', 'Avatar', '02:42:00', '2009-01-01', 'https://www.youtube.com/watch?v=5PSNL1qE6VY', '7.8', 13, 'A paraplegic marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.', 7, 5, 3, 0, 'Avatar.jpeg'),
('6', 'Alien', '01:57:00', '1979-01-01', 'https://www.youtube.com/watch?v=LjLamj-b0I8', '8.4', 17, 'After a space merchant vessel receives an unknown transmission as a distress call, the crew investigates a planet where they encounter a deadly alien.', 4, 6, 3, 0, 'Alien.jpeg'),
('7', 'Inception', '02:28:00', '2010-01-01', 'https://www.youtube.com/watch?v=YoHD9XEInc0', '8.8', 13, 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', 4, 2, 3, 0, 'Inception.jpeg')
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('8', 'The Godfather', '02:55:00', '1972-01-01', 'https://www.youtube.com/watch?v=sY1S34973zA', '9.2', 18, 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 3, 3, 3, 0, 'The Godfather.jpeg'),
('9', 'The Shawshank Redemption', '02:22:00', '1994-01-01', 'https://www.youtube.com/watch?v=6hB3S9bIaco', '9.3', 18, 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', 3, 4, 2, 0, 'The Shawshank Redemption.jpeg'),
('10', 'Forrest Gump', '02:22:00', '1994-01-01', 'https://www.youtube.com/watch?v=bLvqoHBptjg', '8.8', 13, 'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold through the perspective of an Alabama man with an IQ of 75.', 6, 1, 1, 0, 'Forrest Gump.jpeg'),
('11', 'Goodfellas', '02:26:00', '1990-01-01', 'https://www.youtube.com/watch?v=qo5jJpHtI1Y', '8.7', 18, 'The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito in the Italian-American crime syndicate.', 3, 4, 2, 0, 'Goodfellas.jpeg'),
('12', 'Blade Runner', '01:57:00', '1982-01-01', 'https://www.youtube.com/watch?v=KPcZHjKJBnE', '8.1', 17, 'A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.', 7, 6, 3, 0, 'Blade Runner.jpeg'),
('13', 'The Silence of the Lambs', '01:58:00', '1991-01-01', 'https://www.youtube.com/watch?v=W6Mm8Sbe__o', '8.6', 18, 'A young F.B.I. cadet must receive the help of an incarcerated and manipulative cannibal killer to help catch another serial killer, a madman who skins his victims.', 4, 7, 2, 0, 'The Silence of the Lambs.jpeg')
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('14', 'The Lord of the Rings: The Fellowship of the Ring', '02:58:00', '2001-01-01', 'https://www.youtube.com/watch?v=V75dMMIW2B4', '8.8', 13, 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.', 1, 8, 3, 0, 'The Lord of the Rings- The Fellowship of the Ring.jpeg'),
('15', 'The Matrix', '02:16:00', '1999-01-01', 'https://www.youtube.com/watch?v=vKQi3bBA1y8', '8.7', 18, 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.', 4, 9, 2, 0, 'The Matrix.jpeg'),
('16', 'Fight Club', '02:19:00', '1999-01-01', 'https://www.youtube.com/watch?v=SUXWAEX2jlg', '8.8', 18, 'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.', 3, 10, 2, 0, 'Fight Club.jpeg'),
('17', 'The Shawshank Redemption', '02:22:00', '1994-01-01', 'https://www.youtube.com/watch?v=6hB3S9bIaco', '9.3', 18, 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', 3, 4, 2, 0, 'The Shawshank Redemption.jpeg'),
('18', 'Inception', '02:28:00', '2010-01-01', 'https://www.youtube.com/watch?v=YoHD9XEInc0', '8.8', 13, 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.', 4, 2, 3, 0, 'Inception.jpeg'),
('19', 'The Dark Knight Rises', '02:44:00', '2012-01-01', 'https://www.youtube.com/watch?v=g8evyE9TuYk', '8.4', 13, 'Eight years after the Joker''s reign of anarchy, Batman, with the help of the enigmatic Catwoman, is forced from his exile to save Gotham City from the brutal guerrilla terrorist Bane.', 1, 2, 3, 0, 'The Dark Knight Rises.jpeg'),
('20', 'The Avengers', '02:23:00', '2012-01-01', 'https://www.youtube.com/watch?v=eOrNdBpGMv8', '8.0', 13, 'Earth''s mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.', 2, 11, 1, 0, 'The Avengers.jpeg'),
('21', 'Interstellar', '02:49:00', '2014-01-01', 'https://www.youtube.com/watch?v=zSWdZVtXT7E', '8.6', 13, 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.', 7, 12, 2, 0, 'Interstellar.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('22', 'The Lion King', '01:28:00', '1994-01-01', 'https://www.youtube.com/watch?v=4sj1MT05lAA', '8.5', 0, 'Lion prince Simba and his father are targeted by his bitter uncle, who wants to ascend the throne himself.', 9, 13, 1, 0, 'The Lion King.jpeg'),
('23', 'Gladiator', '02:35:00', '2000-01-01', 'https://www.youtube.com/watch?v=Q-b7B8tOAQU', '8.5', 18, 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.', 3, 14, 3, 0, 'Gladiator.jpeg'),
('24', 'The Social Network', '02:00:00', '2010-01-01', 'https://www.youtube.com/watch?v=lB95KLmpLR4', '7.7', 13, 'As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.', 2, 15, 2, 0, 'The Social Network.jpeg'),
('25', 'Back to the Future', '01:56:00', '1985-01-01', 'https://www.youtube.com/watch?v=qvsgGtivCgs', '8.5', 0, 'Marty McFly, a 17-year-old high school student, is accidentally sent thirty years into the past in a time-traveling DeLorean invented by his close friend, the eccentric scientist Doc Brown.', 4, 16, 2, 0, 'Back to the Future.jpeg'),
('26', 'The Pursuit of Happyness', '01:57:00', '2006-01-01', 'https://www.youtube.com/watch?v=89Kq8SDyvfg', '8.0', 13, 'A struggling salesman takes custody of his son as he''s poised to begin a life-changing professional endeavor.', 6, 17, 1, 0, 'The Pursuit of Happyness.jpeg'),
('27', 'The Prestige', '02:10:00', '2006-01-01', 'https://www.youtube.com/watch?v=o4gHCmTQDVI', '8.5', 13, 'After a tragic accident, two stage magicians engage in a battle to create the ultimate illusion while sacrificing everything they have to outwit each other.', 4, 18, 2, 0, 'The Prestige.jpeg'),
('28', 'The Great Gatsby', '02:23:00', '2013-01-01', 'https://www.youtube.com/watch?v=rARN6agiW7o', '7.2', 13, 'A writer and wall street trader, Nick, finds himself drawn to the past and lifestyle of his millionaire neighbor, Jay Gatsby.', , 19, 1, 0, 'The Great Gatsby.jpeg')
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('29', 'The Incredibles', '01:55:00', '2004-01-01', 'https://www.youtube.com/watch?v=eZbzbC9285I', '8.0', 0, 'A family of undercover superheroes, while trying to live the quiet suburban life, are forced into action to save the world.', 9, 20, 1, 0, 'The Incredibles.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('30', 'The Notebook', '02:03:00', '2004-01-01', 'https://www.youtube.com/watch?v=FC6biTjEyZw', '7.8', 13, 'A poor yet passionate young man falls in love with a rich young woman, giving her a sense of freedom, but they are soon separated because of their social differences.', 6, 21, 1, 0, 'The Notebook.jpeg'),
('31', 'Pulp Fiction', '02:34:00', '1994-01-01', 'https://www.youtube.com/watch?v=s7EdQ4FqbhY', '8.9', 18, 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 3, 22, 2, 0, 'Pulp Fiction.jpeg'),
('32', 'The Sixth Sense', '01:47:00', '1999-01-01', 'https://www.youtube.com/watch?v=VG9AGf66tXM', '8.1', 13, 'A boy who communicates with spirits seeks the help of a disheartened child psychologist.', 8, 23, 1, 0, 'The Sixth Sense.jpeg'),
('33', 'Forrest Gump', '02:22:00', '1994-01-01', 'https://www.youtube.com/watch?v=bLvqoHBptjg', '8.8', 13, 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold through the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.', 3, 4, 2, 0, 'Forrest Gump.jpeg'),
('34', 'Avatar', '02:42:00', '2009-01-01', 'https://www.youtube.com/watch?v=5PSNL1qE6VY', '7.8', 13, 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.', 7, 24, 3, 0, 'Avatar.jpeg'),
('35', 'The Silence of the Lambs', '01:58:00', '1991-01-01', 'https://www.youtube.com/watch?v=lQKs169Sl0I', '8.6', 18, 'A young F.B.I. cadet must confide in an incarcerated and manipulative killer to receive his help on catching another serial killer who skins his victims.', 3, 25, 2, 0, 'The Silence of the Lambs.jpeg'),
('36', 'The Departed', '02:31:00', '2006-01-01', 'https://www.youtube.com/watch?v=SGWvwjZ0eDc', '8.5', 18, 'An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston.', 3, 26, 3, 0, 'The Departed.jpeg')
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('37', 'Fargo', '01:38:00', '1996-01-01', 'https://www.youtube.com/watch?v=h2tY82z3xXU', '8.1', 18, 'Jerry Lundegaard''s inept crime falls apart due to his and his henchmen''s bungling and the persistent police work of the quite pregnant Marge Gunderson.', 3, 27, 2, 0, 'Fargo.jpeg'),
('38', 'Black Swan', '01:48:00', '2010-01-01', 'https://www.youtube.com/watch?v=5jaI1XOB-bs', '8.0', 18, 'A committed dancer struggles to maintain her sanity after winning the lead role in a production of Tchaikovsky''s "Swan Lake".', 4, 29, 1, 0, 'Black Swan.jpeg'),
('39', 'Snatch', '01:44:00', '2000-01-01', 'https://www.youtube.com/watch?v=ni4tEtuTccc', '8.3', 18, 'Unscrupulous boxing promoters, violent bookmakers, a Russian gangster, incompetent amateur robbers, and supposedly Jewish jewelers fight to track down a priceless stolen diamond.', 3, 30, 2, 0, 'Snatch.jpeg'),
('40', 'The Lord of the Rings: The Fellowship of the Ring', '02:58:00', '2001-01-01', 'https://www.youtube.com/watch?v=V75dMMIW2B4', '8.8', 13, 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.', 7, 31, 3, 0, 'The Lord of the Rings - The Fellowship of the Ring.jpeg'),
('41', 'Birdman', '01:59:00', '2014-01-01', 'https://www.youtube.com/watch?v=8jAfBd3g6bA', '7.7', 18, 'Illustrated upon the progress of his latest Broadway play, a former popular actor''s struggle to cope with his current life as a wasted actor is shown.', 2, 32, 2, 0, 'Birdman.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('42', 'The Godfather', '02:55:00', '1972-01-01', 'https://www.youtube.com/watch?v=sY1S34973zA', '9.2', 18, 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 3, 16, 1, 0, 'The Godfather.jpeg'),
('43', 'Schindler''s List', '03:15:00', '1993-01-01', 'https://www.youtube.com/watch?v=JdRGC-w9syA', '8.9', 18, 'In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.', 3, 17, 2, 0, 'Schindlers List.jpeg'),
('44', 'The Matrix', '02:16:00', '1999-01-01', 'https://www.youtube.com/watch?v=vKQi3bBA1y8', '8.7', 18, 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.', 1, 12, 3, 0, 'The Matrix.jpeg'),
('45', 'The Usual Suspects', '01:46:00', '1995-01-01', 'https://www.youtube.com/watch?v=oiXdPolca5w', '8.5', 18, 'A sole survivor tells of the twisty events leading up to a horrific gun battle on a boat, which began when five criminals met at a seemingly random police lineup.', 3, 13, 2, 0, 'The Usual Suspects.jpeg'),
('46', 'Braveheart', '02:58:00', '1995-01-01', 'https://www.youtube.com/watch?v=wj0I8xVTV18', '8.3', 18, 'When his secret bride is executed for assaulting an English soldier who tried to rape her, William Wallace begins a revolt against King Edward I of England.', 1, 14, 3, 0, 'Braveheart.jpeg'),
('47', 'The Social Network', '02:00:00', '2010-01-01', 'https://www.youtube.com/watch?v=lB95KLmpLR4', '7.7', 13, 'As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.', 2, 11, 2, 0, 'The Social Network.jpeg'),
('48', 'Interstellar', '02:49:00', '2014-01-01', 'https://www.youtube.com/watch?v=0vxOhd4qlnA', '8.6', 13, 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.', 7, 8, 1, 0, 'Interstellar.jpeg'),
('49', 'American Beauty', '02:02:00', '1999-01-01', 'https://www.youtube.com/watch?v=hIq4UTgqDAc', '8.3', 18, 'A sexually frustrated suburban father has a mid-life crisis after becoming infatuated with his daughter''s best friend.', 3, 9, 2, 0, 'American Beauty.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('50', 'Pulp Fiction', '02:34:00', '1994-01-01', 'https://www.youtube.com/watch?v=s7EdQ4FqbhY', '8.9', 18, 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 3, 10, 2, 0, 'Pulp Fiction.jpeg'),
('51', 'Goodfellas', '02:26:00', '1990-01-01', 'https://www.youtube.com/watch?v=qo5jJpHtI1Y', '8.7', 18, 'The story of Henry Hill and his life in the mob, covering his relationship with his wife Karen Hill and his mob partners Jimmy Conway and Tommy DeVito in the Italian-American crime syndicate.', 3, 11, 3, 0, 'Goodfellas.jpeg'),
('52', 'Jaws', '02:04:00', '1975-01-01', 'https://www.youtube.com/watch?v=U1fu_sA7XhE', '8.0', 13, 'When a killer shark unleashes chaos on a beach resort, its up to a local sheriff, a marine biologist, and an old seafarer to hunt the beast down.', 7, 12, 1, 0, 'Jaws.jpeg'),
('53', 'E.T. the Extra-Terrestrial', '01:55:00', '1982-01-01', 'https://www.youtube.com/watch?v=qYAETtIIClk', '7.8', 0, 'A troubled child summons the courage to help a friendly alien escape Earth and return to his home world.', 7, 12, 1, 0, 'ET the Extra-Terrestrial.jpeg'),
('54', 'The Lion King', '01:28:00', '1994-01-01', 'https://www.youtube.com/watch?v=4sj1MT05lAA', '8.5', 0, 'Lion prince Simba and his father are targeted by his bitter uncle, who wants to ascend the throne himself.', 9, 13, 2, 0, 'The Lion King.jpeg'),
('55', 'Forrest Gump', '02:22:00', '1994-01-01', 'https://www.youtube.com/watch?v=bLvqoHBptjg', '8.8', 13, 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal and other historical events unfold through the perspective of an Alabama man with an IQ of 75.', 3, 14, 1, 0, 'Forrest Gump.jpeg'),
('56', 'Titanic', '03:15:00', '1997-01-01', 'https://www.youtube.com/watch?v=2e-eXJ6HgkQ', '7.8', 13, 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.', 3, 15, 3, 0, 'Titanic.jpeg'),
('57', 'The Shawshank Redemption', '02:22:00', '1994-01-01', 'https://www.youtube.com/watch?v=6hB3S9bIaco', '9.3', 18, 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', 3, 16, 1, 0, 'The Shawshank Redemption.jpeg');
go
-- Movies table inserts
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('58', 'Romeo + Juliet', '02:00:00', '1996-01-01', 'https://www.youtube.com/watch?v=ozmrJHaiWUY', '6.7', 13, 'Shakespeare''s famous play is updated to the hip modern suburb of Verona still retaining its original dialogue.', 4, 17, 2, 0, 'Romeo + Juliet.jpeg'),
('59', 'Mr. & Mrs. Smith', '02:00:00', '2005-01-01', 'https://www.youtube.com/watch?v=BK4rV9Aqf6g', '6.5', 18, 'A bored married couple is surprised to learn that they are both assassins hired by competing agencies to kill each other.', 4, 18, 2, 0, 'Mr and Mrs Smith.jpeg'),
('60', 'The Notebook', '02:03:00', '2004-01-01', 'https://www.youtube.com/watch?v=S3G3fILPQAU', '7.8', 0, 'A poor yet passionate young man falls in love with a rich young woman, giving her a sense of freedom, but they are soon separated because of their social differences.', 6, 19, 1, 0, 'The Notebook.jpeg'),
('61', 'Mission: Impossible - Fallout', '02:27:00', '2018-01-01', 'https://www.youtube.com/watch?v=wb49-oV0F78', '7.7', 13, 'Ethan Hunt and his IMF team, along with some familiar allies, race against time after a mission gone wrong.', 1, 20, 3, 0, 'Mission Impossible - Fallout.jpeg'),
('62', 'Casino Royale', '02:24:00', '2006-01-01', 'https://www.youtube.com/watch?v=36mnx8dBbGE', '8.0', 13, 'After earning 00 status and a license to kill, Secret Agent James Bond sets out on his first mission as 007.', 1, 21, 2, 0, 'Casino Royale.jpeg'),
('63', 'La La Land', '02:08:00', '2016-01-01', 'https://www.youtube.com/watch?v=DBUXcNTjviI', '8.0', 0, 'While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations for the future.', 4, 22, 2, 0, 'La La Land.jpeg'),
('64', 'Die Hard', '02:12:00', '1988-01-01', 'https://www.youtube.com/watch?v=2TQ-pOvI6Xo', '8.2', 18, 'An NYPD officer tries to save his wife and several others taken hostage by German terrorists during a Christmas party at the Nakatomi Plaza in Los Angeles.', 1, 23, 3, 0, 'Die Hard.jpeg'),
('65', 'The Fault in Our Stars', '02:06:00', '2014-01-01', 'https://www.youtube.com/watch?v=9ItBvH5J6ss', '7.7', 13, 'Two teenage cancer patients begin a life-affirming journey to visit a reclusive author in Amsterdam.', 6, 24, 1, 0, 'The Fault in Our Stars.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('66', 'The Conjuring', '01:52:00', '2013-01-01', 'https://www.youtube.com/watch?v=k10ETZ41q5o', '7.5', 18, 'Paranormal investigators Ed and Lorraine Warren work to help a family terrorized by a dark presence in their farmhouse.', 5, 17, 1, 0, 'The Conjuring.jpeg'),
('67', 'Get Out', '01:44:00', '2017-01-01', 'https://www.youtube.com/watch?v=DzfpyUB60YY', '7.7', 18, 'A young African-American visits his white girlfriend''s parents for the weekend, where his simmering uneasiness about their reception of him eventually reaches a boiling point.', 5, 18, 2, 0, 'Get Out.jpeg'),
('68', 'Hereditary', '02:07:00', '2018-01-01', 'https://www.youtube.com/watch?v=V6wWKNij_1M', '7.3', 18, 'A grieving family is haunted by tragic and disturbing occurrences after the death of their secretive grandmother.', 5, 19, 2, 0, 'Hereditary.jpeg'),
('69', 'Paranormal Activity', '01:26:00', '2007-01-01', 'https://youtu.be/F_UxLEqd074', '6.3', 18, 'After moving into a suburban home, a couple becomes increasingly disturbed by a nightly demonic presence.', 5, 20, 1, 0, 'Paranormal Activity.jpeg'),
('70', 'Man on Wire', '01:34:00', '2008-01-01', 'https://www.youtube.com/watch?v=eiA-OpIcP3Q', '7.8', 0, 'A look at tightrope walker Philippe Petit''s daring, but illegal, high-wire routine performed between New York City''s World Trade Center''s twin towers in 1974, what some consider, "the artistic crime of the century."', 8, 21, 3, 0, 'Man on Wire.jpeg'),
('71', 'Blackfish', '01:23:00', '2013-01-01', 'https://www.youtube.com/watch?v=8OEjYquyjcg', '8.1', 0, 'A documentary following the controversial captivity of killer whales, and its dangers for both humans and whales.', 8, 22, 2, 0, 'Blackfish.jpeg'),
('72', 'The Texas Chain Saw Massacre', '01:23:00', '1974-01-01', 'https://www.youtube.com/watch?v=3y2BjmRL4y0', '7.5', 18, 'Two siblings and three of their friends en route to visit their grandfather''s grave in Texas end up falling victim to a family of cannibalistic psychopaths and must survive the terrors of Leatherface and his family.', 5, 23, 2, 0, 'The Texas Chain Saw Massacre.jpeg');
go
-- Movies table inserts
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('73', 'The Thin Blue Line', '01:41:00', '1988-01-01', 'https://www.youtube.com/watch?v=vY5kyP_Hlcc', '8.0', 0, 'A film that successfully argued that a man was wrongly convicted for murder by a corrupt justice system in Dallas County, Texas.', 8, 17, 1, 0, 'The Thin Blue Line.jpeg'),
('74', 'Searching for Sugar Man', '01:26:00', '2012-01-01', 'https://www.youtube.com/watch?v=QL5TffdOQ7g', '8.2', 0, 'Two South Africans set out to discover what happened to their unlikely musical hero, the mysterious 1970s rock n roller, Rodriguez.', 8, 18, 2, 0, 'Searching for Sugar Man.jpeg'),
('75', 'Exit Through the Gift Shop', '01:27:00', '2010-01-01', 'https://www.youtube.com/watch?v=oHJBdDSTbLw', '8.0', 0, 'The story of how an eccentric French shop-keeper and amateur film-maker attempted to locate and befriend Banksy, only to have the artist turn the camera back on its owner.', 8, 19, 2, 0, 'Exit Through the Gift Shop.jpeg'),
('76', 'The Cove', '01:32:00', '2009-01-01', 'https://www.youtube.com/watch?v=4KRD8e20fBo', '8.4', 0, 'Using state-of-the-art equipment, a group of activists, led by renowned dolphin trainer Ric O''Barry, infiltrate a cove near Taijii, Japan to expose both a shocking instance of animal abuse and a serious threat to human health.', 8, 20, 1, 0, 'The Cove.jpeg'),
('77', 'Grizzly Man', '01:43:00', '2005-01-01', 'https://www.youtube.com/watch?v=tnWKG1RZmJY', '7.8', 0, 'A devastating and heartrending take on grizzly bear activists Timothy Treadwell and Amie Huguenard, who were killed in October of 2003 while living among grizzlies in Alaska.', 8, 21, 3, 0, 'Grizzly Man.jpeg'),
('78', 'March of the Penguins', '01:20:00', '2005-01-01', 'https://www.youtube.com/watch?v=WWvtyZFIzZ0', '7.5', 0, 'In the Antarctic, every March since the beginning of time, the quest begins to find the perfect mate and start a family.', 8, 22, 2, 0, 'March of the Penguins.jpeg'),
('79', 'Jiro Dreams of Sushi', '01:21:00', '2011-01-01', 'https://www.youtube.com/watch?v=hbTg8rrlc2k', '7.9', 0, 'A documentary on 85-year-old sushi master Jiro Ono, his renowned Tokyo restaurant, and his relationship with his son and eventual heir, Yoshikazu.', 8, 23, 2, 0, 'Jiro Dreams of Sushi.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('80', 'Toy Story', '01:21:00', '1995-01-01', 'https://www.youtube.com/watch?v=KYz2wyBy3kc', '8.3', 0, 'A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy''s room.', 9, 1, 1, 0, 'Toy Story.jpeg'),
('81', 'Frozen', '01:42:00', '2013-01-01', 'https://www.youtube.com/watch?v=TbQm5doF_Uc', '7.4', 0, 'When the newly-crowned Queen Elsa accidentally uses her power to turn things into ice to curse her home in infinite winter, her sister Anna teams up with a mountain man, his playful reindeer, and a snowman to change the weather condition.', 9, 2, 2, 0, 'Frozen.jpeg'),
('82', 'The Lion King', '01:28:00', '1994-01-01', 'https://www.youtube.com/watch?v=4sj1MT05lAA', '8.5', 0, 'Lion prince Simba and his father are targeted by his bitter uncle, who wants to ascend the throne himself.', 9, 3, 1, 0, 'The Lion King.jpeg'),
('83', 'Moana', '01:47:00', '2016-01-01', 'https://www.youtube.com/watch?v=LKFuXETZUsI', '7.6', 0, 'In Ancient Polynesia, when a terrible curse incurred by the Demigod Maui reaches Moana''s island, she answers the Ocean''s call to seek out the Demigod to set things right.', 9, 4, 2, 0, 'Moana.jpeg'),
('84', 'Finding Nemo', '01:40:00', '2003-01-01', 'https://www.youtube.com/watch?v=2zLkasScy7A', '8.1', 0, 'After his son is captured in the Great Barrier Reef and taken to Sydney, a timid clownfish sets out on a journey to bring him home.', 9, 5, 2, 0, 'Finding Nemo.jpeg'),
('85', 'Shrek', '01:30:00', '2001-01-01', 'https://www.youtube.com/watch?v=W37DlG1i61s', '7.8', 0, 'A mean lord exiles fairytale creatures to the swamp of a grumpy ogre, who must go on a quest and rescue a princess for the lord in order to get his land back.', 9, 6, 3, 0, 'Shrek.jpeg'),
('86', 'Coco', '01:45:00', '2017-01-01', 'https://www.youtube.com/watch?v=Rvr68u6k5sI', '8.4', 0, 'Aspiring musician Miguel, confronted with his family''s ancestral ban on music, enters the Land of the Dead to find his great-great-grandfather, a legendary singer.', 9, 7, 2, 0, 'Coco.jpeg'),
('87', 'Despicable Me', '01:35:00', '2010-01-01', 'https://www.youtube.com/watch?v=zzCZ1W_CUoI', '7.6', 0, 'When a criminal mastermind uses a trio of orphan girls as pawns for a grand scheme, he finds their love is profoundly changing him for the better.', 9, 8, 1, 0, 'Despicable Me.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('88', '500 Days of Summer', '01:35:00', '2009-01-01', 'https://www.youtube.com/watch?v=PsD0NpFSADM', '7.7', 0, 'An offbeat romantic comedy about a woman who doesnt believe true love exists and the young man who falls for her.', 6, 4, 3, 0, '500 Days of Summer.jpeg'),
('89', 'Eternal Sunshine of the Spotless Mind', '01:48:00', '2004-01-01', 'https://www.youtube.com/watch?v=quuMv7cGUn0', '8.3', 0, 'When their relationship turns sour, a couple undergoes a medical procedure to have each other erased from their memories.', 6, 6, 1, 0, 'Eternal Sunshine of the Spotless Mind.jpeg'),
('90', 'The Proposal', '01:48:00', '2009-01-01', 'https://www.youtube.com/watch?v=RFL8b1p1ELY', '6.7', 0, 'A pushy boss forces her young assistant to marry her in order to keep her Visa status in the U.S. and avoid deportation to Canada.', 6, 7, 2, 0, 'The Proposal.jpeg'),
('91', 'Crazy Rich Asians', '02:00:00', '2018-01-01', 'https://www.youtube.com/watch?v=ZQ-YX-5bAs0', '6.9', 0, 'This contemporary romantic comedy, based on a global bestseller, follows native New Yorker Rachel Chu to Singapore to meet her boyfriend''s family.', 6, 8, 2, 0, 'Crazy Rich Asians.jpeg'),
('92', 'Silver Linings Playbook', '02:02:00', '2012-01-01', 'https://www.youtube.com/watch?v=Lj5_FhLaaQQ', '7.7', 0, 'After a stint in a mental institution, former teacher Pat Solitano moves back in with his parents and tries to reconcile with his ex-wife.', 6, 9, 2, 0, 'Silver Linings Playbook.jpeg')
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('93', 'Love, Rosie', '01:42:00', '2014-01-01', 'https://www.youtube.com/watch?v=0PhHg1Ca3-4', '7.2', 0, 'Rosie and Alex have been best friends since they were 5, so they couldn''t possibly be right for one another... or could they?', 6, 10, 1, 0, 'Love, Rosie.jpeg'),
('94', 'The Time Traveler''s Wife', '01:47:00', '2009-01-01', 'https://www.youtube.com/watch?v=3_8WZxHScMk', '7.1', 0, 'A Chicago librarian has a gene that causes him to involuntarily time travel, creating complications in his marriage.', 6, 11, 2, 0, 'The Time Traveler''s Wife.jpeg'),
('95', 'One Day', '01:47:00', '2011-01-01', 'https://www.youtube.com/watch?v=zVuuooZqVaU', '7.0', 0, 'After spending the night together on the night of their college graduation Dexter and Em are shown each year on the same date to see where they are in their lives.', 6, 12, 2, 0, 'One Day.jpeg'),
('96', 'A Walk to Remember', '01:41:00', '2002-01-01', 'https://www.youtube.com/watch?v=kP7yEuLvM4Y', '7.3', 0, 'The story of two North Carolina teens, Landon Carter and Jamie Sullivan, who are thrown together after Landon gets into trouble and is made to do community service.', 6, 13, 3, 0, 'A Walk to Remember.jpeg'),
('97', 'The Choice', '01:51:00', '2016-01-01', 'https://www.youtube.com/watch?v=2Z0RiE2ELmI', '6.6', 0, 'Travis and Gabby first meet as neighbors in a small coastal town and wind up in a relationship that is tested by life''s most defining events.', 6, 14, 1, 0, 'The Choice.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('98', 'Cocaine Bear', '01:35:00', '2023-01-01', 'https://youtu.be/DuWEEKeJLMI', '7.2', 0, 'An oddball group of cops, criminals, tourists and teens converge on a Georgia forest where a huge black bear goes on a murderous rampage after unintentionally ingesting cocaine.', 1, 41, 1, 0, 'Cocaine Bear.jpeg'),
('99', 'Guardians of the Galaxy Vol.3', '02:30:00', '2023-01-01', 'https://youtu.be/u3V5KDHRQvk', '7.1', 0, 'Still reeling from the loss of Gamora, Peter Quill rallies his team to defend the universe and one of their own - a mission that could mean the end of the Guardians if not successful.', 1, 42, 2, 0, 'Guardians of the Galaxy.jpeg'),
('100', 'Plane', '01:47:00', '2023-01-01', 'https://youtu.be/M25zXBIUVr0', '7.0', 0, 'A pilot finds himself caught in a war zone after he is forced to land his commercial aircraft during a terrible storm.', 1, 43, 2, 0, 'Plane.jpeg'),
('101', 'Shazam!', '02:10:00', '2023-01-01', 'https://youtu.be/Zi88i4CpHe4', '7.3', 0, 'The film continues the story of teenage Billy Batson who, upon reciting the magic word "SHAZAM!" is transformed into his adult Super Hero alter ego, Shazam.', 1, 44, 3, 0, 'Shazam!.jpeg'),
('102', 'Glass Onion', '02:20:00', '2016-01-01', 'https://youtu.be/gj5ibYSz8C0', '6.6', 0, 'Famed Southern detective Benoit Blanc travels to Greece for his latest case..', 2, 45, 1, 0, 'Glass Onion.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('103', 'Good Boys', '01:30:00', '2019-01-01', 'https://youtu.be/zPXqwAGmX04', '7.2', 0, 'Three 6th grade boys ditch school and embark on an epic journey while carrying accidentally stolen drugs, being hunted by teenage girls, and trying to make their way home in time for a long-awaited party.', 2, 46, 1, 0, 'Good Boys.jpeg'),
('104', 'Joyride', '02:30:00', '2022-01-01', 'https://youtu.be/lkVDCiJdGAg', '7.1', 0, 'A headstrong solicitor plan to offload her new born baby to her sister,is derailed and vulnerable but opinionated teenager steals their taxi.', 2, 47, 2, 0, 'Joyride.jpeg'),
('105', 'Me Time', '01:47:00', '2022-01-01', 'https://youtu.be/Mmq_NVwLN_g', '7.0', 0, 'Follows a dad who finds time for himself for the first time in years while his wife and kids are away. He reconnects with a friend for a wild weekend.', 2, 48, 2, 0, 'Me Time.jpeg'),
('106', 'Shazam!', '02:10:00', '2023-01-01', 'https://youtu.be/go6GEIrcvFY', '7.3', 0, 'The film continues the story of teenage Billy Batson who, upon reciting the magic word "SHAZAM!" is transformed into his adult Super Hero alter ego, Shazam.', 2, 49, 3, 0, 'Shazam!.jpeg'),
('107', 'The Bad Guys', '01:40:00', '2022-01-01', 'https://youtu.be/m8Xt0yXaDPU', '6.6', 0, 'To avoid prison, a gang of notorious animal criminals pretends to seek being rehabilitated, only for their leader to realize that he genuinely wants to change his ways.', 2, 50, 1, 0, 'The Bad Guys.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('108', 'The Estate', '01:36:00', '2022-01-01', 'https://youtu.be/DqTEVmed0Bc', '7.2', 0, 'Two sisters attempt to win over their terminally ill, difficult-to-please Aunt in hopes of becoming the beneficiaries of her wealthy estate, only to find the rest of their greedy family members have the same idea.', 2, 51, 1, 0, 'The Estate.jpeg'),
('109', 'The Man From Toronto', '01:50:00', '2022-01-01', 'https://youtu.be/urqy8DrcGBs', '7.1', 0, 'The world deadliest assassin and New York biggest screw-up are mistaken for each other at an Airbnb rental.', 2, 52, 2, 0, 'The Man From Toronto.jpeg'),
('110', 'Violent Night', '01:52:00', '2022-01-01', 'https://youtu.be/a53e4HHnx_s', '7.0', 0, 'When a group of mercenaries attack the estate of a wealthy family, Santa Claus must step in to save the day (and Christmas).', 2, 53, 2, 0, 'Violent Night.jpeg'),
('111', 'Halloween Ends', '01:51:00', '2022-01-01', 'https://youtu.be/s0vtbxLa-N8', '7.3', 0, 'The film continues the story of teenage Billy Batson who, upon reciting the magic word "SHAZAM!" is transformed into his adult Super Hero alter ego, Shazam.', 5, 54, 3, 0, 'Halloween Ends.jpeg'),
('112', 'The Curse of Bridge Hollows', '01:29:00', '2022-01-01', 'https://youtu.be/Y-eYqE_X9N8', '6.6', 0, 'To avoid prison, a gang of notorious animal criminals pretends to seek being rehabilitated, only for their leader to realize that he genuinely wants to change his ways.', 5, 55, 1, 0, 'The Curse of Brigde Hollow.jpeg');
go
INSERT INTO Movies (MovieID, MovieTitle, Runtime, Release_Year, TrailerLink, Ratings, AgeRating, ShortDiscription, CatergoryID, DirectorID, SubID, Views, ImageName) VALUES
('113', 'Boss Baby', '01:36:00', '2017-01-01', 'https://youtu.be/tquIfapGVqs', '7.2', 0, 'A suit-wearing, briefcase-carrying baby pairs up with his 7-year old brother to stop the dastardly plot of the CEO of Puppy Co.', 2, 56, 1, 0, 'Boss Baby.jpeg'),
('114', 'The Takeover', '01:27:00', '2022-01-01', 'https://youtu.be/KutXTcm-s3Q', '7.1', 0, 'Framed for murder after uncovering a privacy scandal, an ethical hacker must evade the police while trying to track down the criminals blackmailing her.', 7, 57, 2, 0, 'The Takeover.jpeg'),
('115', 'Wifelike', '01:45:00', '2022-01-01', 'https://youtu.be/Q0who82bdhU', '7.0', 0, 'When artificial human Meredith is assigned as a companion to grieving widower William, she is designed to behave like his late wife. But in the fight to end AI exploitation, an organization attempts to sabotage her programming.', 7, 58, 2, 0, 'Wifelike.jpeg');
go
--Run after all movies inserts 
update Movies 
set TrailerLInk = REPLACE(TrailerLInk,'watch?v=', 'embed/')
go
update Movies set MovieTitle = replace(MovieTitle,':','')
go
insert into Admin (AdminID, Fname,Lname,email) values (2,'Admin','Account','Admin@321movies.com')
go
 update Admin set Password = '123'

