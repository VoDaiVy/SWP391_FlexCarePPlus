create database FlexCarePPlus

use FlexCarePPlus

create table Policy(
PolicyID int identity(1,1) primary key,
Title nvarchar(100) null,
Description nvarchar(MAX) null,
DataCreated date default getdate(),
Status bit not null
)

create table CategoryService(
CategoryServiceID int identity(1,1) primary key,
Name nvarchar(100) null,
Status bit not null,
)

create table Service(
ServiceID int identity(1,1) primary key,
CategoryServiceID int not null,
Name nvarchar(100) null,
Description nvarchar(MAX) null,
Price money null,
Time int null,
Views int null,
ImgURL varchar(MAX) null,
Status bit null,
constraint FK_Service_CategoryService foreign key (CategoryServiceID) references CategoryService(CategoryServiceID)
)

create table ServiceImage(
ServiceImageID int identity(1,1) primary key,
ServiceID int not null,
ImgURL varchar(MAX),
constraint FK_ServiceImage_Service foreign key (ServiceID) references Service(ServiceID)
)

create table Room(
RoomID int identity(1,1) primary key,
CategoryServiceID  int not null,
Name nvarchar(100) null,
RoomNumber int null,
Status bit null,
constraint FK_Room_CategoryService foreign key (CategoryServiceID) references CategoryService(CategoryServiceID)
)

create table Users(
UserID int identity(1,1) primary key,
UserName varchar(100) unique null,
PassWord varchar(100) null,
Email varchar(100) unique null,
Status bit default 1,
Role varchar(50) null
)

create table Booking(
BookingID int identity(1,1) primary key,
UserID int not null,
DataBooked datetime default getdate(),
TotalPrice money null,
Paid money null,
State nvarchar(100) null,
Note nvarchar(MAX) null,
Status bit null,
constraint FK_Booking_User foreign key (UserID) references Users(UserID)
)

create table Pet(
PetID int identity(1,1) primary key,
Name varchar(50) not null
)

create table UserPet(
UserPetID int identity(1,1) primary key,
UserID int not null,
PetID int not null,
PetName nvarchar(100) null,
constraint FK_UserPet_User foreign key (UserID) references Users(UserID),
constraint FK_UserPet_Pet foreign key (PetID) references Pet(PetID)
)

create table BookingDetail(
BookingDetailID int identity(1,1) primary key,
BookingID int not null,
ServiceID int not null,
RoomID int not null,
UserPetID int not null,
StockBooking int not null,
DataStartService datetime null,
DataEndService datetime null,
StartTime time null,
EndTime time null,
Price money not null,
constraint FK_BookingDetail_Booking foreign key (BookingID) references Booking(BookingID) ,
constraint FK_BookingDetail_Service foreign key (ServiceID) references Service(ServiceID) ,
constraint FK_BookingDetail_Room foreign key (RoomID) references Room(RoomID) ,
constraint FK_BookingDetail_UserPet foreign key (UserPetID) references UserPet(UserPetID)
)

create table MedicalRecords(
MedicalRecordsID int identity(1,1) primary key,
UserPetID int not null,
UserID int not null,
DateVisit datetime default getdate(),
Condition nvarchar(MAX) null,
Diagnosis nvarchar(MAX) null,
Treatment nvarchar(MAX) null,
Notes nvarchar(MAX) null,
TreatmentStart datetime null,
TreatmentEnd datetime null,
FollowUpRequired bit null,
NextBookingID int null,
State nvarchar(100) null,
Status bit null,
constraint FK_MedicalRecordst_User foreign key (UserID) references Users(UserID),
constraint FK_MedicalRecords_UserPet foreign key (UserPetID) references UserPet(UserPetID),
constraint FK_MedicalRecords_Booking foreign key (NextBookingID) references Booking(BookingID),
)

create table FeedbackService(
FeedbackServiceID int identity(1,1) primary key,
UserID int not null,
ServiceID int not null,
BookingID int not null,
DataCreated datetime default getdate(),
Rating int null,
Comment nvarchar(100) null,
Status bit null,
constraint FK_FeedbackService_User foreign key (UserID) references Users(UserID),
constraint FK_FeedbackService_Service foreign key (ServiceID) references Service(ServiceID)
)

create table UserDetail(
UserID int primary key,
FirstName nvarchar(50) null,
LastName nvarchar(50) null,
Tel varchar(10) null,
DOB date null,
Gender nvarchar(30) null,
Avatar nvarchar(MAX) null,
constraint FK_UserDetail_User foreign key (UserID) references Users(UserID),
constraint CK_UserDetail_Tel CHECK (Tel LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
constraint CK_UserDetail_Gender CHECK (Gender in (N'Male',N'Female',N'Other'))
)

create table Message(
MessageID int identity(1,1) primary key,
UserID int not null,
UserReceiveID int not null,
TimeChat datetime default getdate(),
Status bit default 1,
Content nvarchar(MAX) not null,
constraint FK_Message_Person foreign key (UserID) references Users(UserID) ,
constraint FK_Message_PersonReceive foreign key (UserReceiveID) references Users(UserID) 
)

create table Notifications(	
NotificationID int identity(1,1) primary key,
Content nvarchar(MAX) null,
DataCreated datetime default getdate()
)

create table NotificationUser(
NotificationUserID int identity(1,1) primary key,
NotificationID int not null,
UserID int not null,
Status bit default 1,
HasRead bit default 0,
constraint FK_NotificationUser_User foreign key (UserID) references Users(UserID),
constraint FK_NotificationUser_Notifications foreign key (NotificationID) references Notifications(NotificationID)
)

create table Wallet(
UserID int primary key,
Amount money default 0,
Status bit not null,
constraint FK_Wallet_Person foreign key (UserID) references Users(UserID) 
)

create table WalletTransfer (
WalletTransferID int identity(1,1) primary key,
TransCode nvarchar(10),
TimeCode nvarchar(20),
Content nvarchar(20),
UserID int,
Amount money,
IsRefunded bit
)

create table News(
NewsID int identity(1,1) primary key,
Title nvarchar(100) null,
Description nvarchar(MAX) null,
Views int null,
DataCreated date default getdate(),
ImgURL varchar(MAX),
Status bit not null
)

create table NewsImage(
NewsImageID int identity(1,1) primary key,
NewsID int not null,
ImgURL varchar(MAX),
constraint FK_NewsImage_News foreign key (NewsID) references News(NewsID)
)


WITH LatestMessage AS (
    SELECT 
        u.UserID, 
        u.UserName, 
        u.Email, 
        MAX(m.TimeChat) AS LastMessageTime
    FROM Users u
    JOIN Message m ON u.UserID = m.UserID OR u.UserID = m.UserReceiveID
    WHERE u.Status = 1 AND u.Role = 'customer'
    GROUP BY u.UserID, u.UserName, u.Email
)
SELECT u.UserID, u.UserName, u.Email
FROM LatestMessage lm
JOIN Users u ON u.UserID = lm.UserID
ORDER BY lm.LastMessageTime DESC;

ALTER TABLE Room
DROP CONSTRAINT FK_Room_Service;

EXEC sp_rename 'Room.ServiceID', 'CategoryServiceID', 'COLUMN';

ALTER TABLE Room
ADD CONSTRAINT FK_Room_CategoryService
FOREIGN KEY (CategoryServiceID) REFERENCES CategoryService(CategoryServiceID);

EXEC sp_help 'Room';
EXEC sp_rename 'Policy.DataCreated', 'DateCreated', 'COLUMN';

SELECT TOP 10 
    n.NotificationID,
    n.Content,
    nu.HasRead
FROM 
    NotificationUser nu
JOIN 
    Notifications n ON nu.NotificationID = n.NotificationID
WHERE 
    nu.UserID = 1 and nu.Status = 1
ORDER BY 
    n.DateCreated DESC;
