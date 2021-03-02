

/* Create Tables */

CREATE TABLE AppealImg
(
	appealNo number NOT NULL,
	img nvarchar2(50) NOT NULL,
	id varchar2(15) NOT NULL,
	PRIMARY KEY (appealNo)
);


CREATE TABLE BBS
(
	bbsNo number NOT NULL,
	title nvarchar2(50),
	contents nvarchar2(2000) NOT NULL,
	meetingNo number,
	id varchar2(15) NOT NULL,
	division number(1) NOT NULL,
	bbspostdate date DEFAULT SYSDATE,
	PRIMARY KEY (bbsNo)
);


CREATE TABLE BBSAccusation
(
	bAccusationNo number NOT NULL,
	Reason nvarchar2(30) NOT NULL,
	Content nvarchar2(200) NOT NULL,
	bbsNo number NOT NULL,
	id varchar2(15) NOT NULL,
	process nvarchar2(10) NOT NULL,
	PRIMARY KEY (bAccusationNo)
);


CREATE TABLE BBS_Comment
(
	commentNo number NOT NULL,
	contents nvarchar2(200) NOT NULL,
	bbsNo number NOT NULL,
	id varchar2(15) NOT NULL,
	PRIMARY KEY (commentNo)
);


CREATE TABLE BBS_IMG
(
	imgNo number NOT NULL,
	bbsNo number NOT NULL,
	img nvarchar2(30) NOT NULL,
	PRIMARY KEY (imgNo)
);


CREATE TABLE Category
(
	categoryNo number NOT NULL,
	maincategory nvarchar2(15) NOT NULL,
	subcategory nvarchar2(15) NOT NULL,
	PRIMARY KEY (categoryNo)
);


CREATE TABLE chatting
(
	chatNo number NOT NULL,
	meetingNo number NOT NULL,
	name nvarchar2(10) NOT NULL,
	PRIMARY KEY (chatNo)
);


CREATE TABLE chat_member
(
	roleNo number NOT NULL,
	chatNo number NOT NULL,
	name nvarchar2(10) NOT NULL,
	UNIQUE (roleNo, chatNo)
);


CREATE TABLE Donation
(
	donationNo number NOT NULL,
	meetingNo number NOT NULL,
	id varchar2(15) NOT NULL,
	donation number NOT NULL,
	PRIMARY KEY (donationNo)
);


CREATE TABLE funding
(
	meetingNo number NOT NULL,
	amount number DEFAULT 0 NOT NULL,
	fundingenddate date,
	enabled number(1),
	PRIMARY KEY (meetingNo)
);


CREATE TABLE Interests
(
	interestsNo number NOT NULL,
	id varchar2(15) NOT NULL,
	categoryNo number NOT NULL,
	PRIMARY KEY (interestsNo)
);


CREATE TABLE Like_BBS
(
	likeBNo number NOT NULL,
	bbsNo number NOT NULL,
	id varchar2(15) NOT NULL,
	PRIMARY KEY (likeBNo)
);


CREATE TABLE Like_Meeting
(
	likeno number NOT NULL,
	id varchar2(15) NOT NULL,
	meetingNo number NOT NULL,
	PRIMARY KEY (likeno)
);


CREATE TABLE Meeting
(
	meetingNo number NOT NULL,
	meetingname nvarchar2(20) NOT NULL,
	operator varchar2(15) NOT NULL,
	opendate date DEFAULT SYSDATE NOT NULL,
	enddate date NOT NULL,
	town nvarchar2(30) NOT NULL,
	meetingdescription nvarchar2(1000) NOT NULL,
	categoryNo number NOT NULL,
	warningcount number,
	enabled number(1),
	bannerimg nvarchar2(30),
	maxrole number(2),
	PRIMARY KEY (meetingNo)
);


CREATE TABLE MeetingAccusation
(
	mAccusationNo number NOT NULL,
	Reason nvarchar2(30) NOT NULL,
	Content nvarchar2(200) NOT NULL,
	id varchar2(15) NOT NULL,
	meetingNo number NOT NULL,
	process nvarchar2(10) NOT NULL,
	PRIMARY KEY (mAccusationNo)
);


CREATE TABLE MeetingHistory
(
	historyNo number NOT NULL,
	id varchar2(15) NOT NULL,
	progress varchar2(1) NOT NULL,
	meetingNo number NOT NULL,
	PRIMARY KEY (historyNo)
);


CREATE TABLE MeetingRole
(
	roleNo number NOT NULL,
	rolename nvarchar2(20) NOT NULL,
	id varchar2(15),
	meetingNo number NOT NULL,
	name nvarchar2(15),
	enabled number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (roleNo)
);


CREATE TABLE Meetingwarning
(
	mwarningno number NOT NULL,
	reason nvarchar2(30) NOT NULL,
	result nvarchar2(20),
	postdate date DEFAULT SYSDATE,
	meetingNo number NOT NULL,
	PRIMARY KEY (mwarningno)
);


CREATE TABLE Member
(
	id varchar2(15) NOT NULL,
	pwd varchar2(15) NOT NULL,
	name nvarchar2(15),
	age number(3),
	gender char(1),
	tel varchar2(11) NOT NULL,
	profileimg nvarchar2(30),
	pr nvarchar2(50),
	about_me nvarchar2(1000),
	postdate date DEFAULT SYSDATE NOT NULL,
	authority varchar2(20) DEFAULT 'ROLE_USER' NOT NULL,
	enabled number(1) DEFAULT 1 NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE memberwarning
(
	mwarninno number NOT NULL,
	reason nvarchar2(30) NOT NULL,
	result nvarchar2(20) NOT NULL,
	postdate date DEFAULT SYSDATE,
	id varchar2(15) NOT NULL,
	PRIMARY KEY (mwarninno)
);


CREATE TABLE message
(
	messageNo number NOT NULL,
	content nvarchar2(50) NOT NULL,
	chatNo number NOT NULL,
	roleNo number NOT NULL,
	postDate date DEFAULT SYSDATE NOT NULL,
	division number NOT NULL,
	PRIMARY KEY (messageNo)
);


CREATE TABLE Notice
(
	noticeNo number NOT NULL,
	title nvarchar2(50) NOT NULL,
	content nvarchar2(2000) NOT NULL,
	enabled number(1),
	PRIMARY KEY (noticeNo)
);


CREATE TABLE Notice_file
(
	fileNo number NOT NULL,
	noticeNo number NOT NULL,
	path varchar2(50) NOT NULL,
	filename nvarchar2(20) NOT NULL,
	filetype varchar2(10) NOT NULL,
	filesize varchar2(10) NOT NULL,
	PRIMARY KEY (fileNo)
);


CREATE TABLE performance
(
	performanceno number NOT NULL,
	meetingNo number NOT NULL,
	title nvarchar2(20),
	perform_date date,
	perform_time varchar2(10),
	place nvarchar2(50),
	main_img nvarchar2(30),
	content nvarchar2(2000),
	PRIMARY KEY (performanceno)
);


CREATE TABLE star_meeting
(
	starno number NOT NULL,
	value number,
	meetingNo number NOT NULL,
	id varchar2(15) NOT NULL,
	PRIMARY KEY (starno)
);


CREATE TABLE Town
(
	townNo number NOT NULL,
	town nvarchar2(30),
	id varchar2(15) NOT NULL,
	PRIMARY KEY (townNo)
);



/* Create Foreign Keys */

ALTER TABLE BBSAccusation
	ADD FOREIGN KEY (bbsNo)
	REFERENCES BBS (bbsNo)
;


ALTER TABLE BBS_Comment
	ADD FOREIGN KEY (bbsNo)
	REFERENCES BBS (bbsNo)
;


ALTER TABLE BBS_IMG
	ADD FOREIGN KEY (bbsNo)
	REFERENCES BBS (bbsNo)
;


ALTER TABLE Like_BBS
	ADD FOREIGN KEY (bbsNo)
	REFERENCES BBS (bbsNo)
;


ALTER TABLE Interests
	ADD FOREIGN KEY (categoryNo)
	REFERENCES Category (categoryNo)
;


ALTER TABLE Meeting
	ADD FOREIGN KEY (categoryNo)
	REFERENCES Category (categoryNo)
;


ALTER TABLE chat_member
	ADD FOREIGN KEY (chatNo)
	REFERENCES chatting (chatNo)
;


ALTER TABLE message
	ADD FOREIGN KEY (chatNo)
	REFERENCES chatting (chatNo)
;


ALTER TABLE Donation
	ADD FOREIGN KEY (meetingNo)
	REFERENCES funding (meetingNo)
;


ALTER TABLE BBS
	ADD FOREIGN KEY (meetingNo)
	REFERENCES Meeting (meetingNo)
;


ALTER TABLE chatting
	ADD FOREIGN KEY (meetingNo)
	REFERENCES Meeting (meetingNo)
;


ALTER TABLE funding
	ADD FOREIGN KEY (meetingNo)
	REFERENCES Meeting (meetingNo)
;


ALTER TABLE Like_Meeting
	ADD FOREIGN KEY (meetingNo)
	REFERENCES Meeting (meetingNo)
;


ALTER TABLE MeetingAccusation
	ADD FOREIGN KEY (meetingNo)
	REFERENCES Meeting (meetingNo)
;


ALTER TABLE MeetingHistory
	ADD FOREIGN KEY (meetingNo)
	REFERENCES Meeting (meetingNo)
;


ALTER TABLE MeetingRole
	ADD FOREIGN KEY (meetingNo)
	REFERENCES Meeting (meetingNo)
;


ALTER TABLE Meetingwarning
	ADD FOREIGN KEY (meetingNo)
	REFERENCES Meeting (meetingNo)
;


ALTER TABLE performance
	ADD FOREIGN KEY (meetingNo)
	REFERENCES Meeting (meetingNo)
;


ALTER TABLE star_meeting
	ADD FOREIGN KEY (meetingNo)
	REFERENCES Meeting (meetingNo)
;


ALTER TABLE chat_member
	ADD FOREIGN KEY (roleNo)
	REFERENCES MeetingRole (roleNo)
;


ALTER TABLE message
	ADD FOREIGN KEY (roleNo)
	REFERENCES MeetingRole (roleNo)
;


ALTER TABLE AppealImg
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE BBS
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE BBSAccusation
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE BBS_Comment
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE Donation
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE Interests
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE Like_BBS
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE Like_Meeting
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE Meeting
	ADD FOREIGN KEY (operator)
	REFERENCES Member (id)
;


ALTER TABLE MeetingAccusation
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE MeetingHistory
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE MeetingRole
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE memberwarning
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE star_meeting
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE Town
	ADD FOREIGN KEY (id)
	REFERENCES Member (id)
;


ALTER TABLE Notice_file
	ADD FOREIGN KEY (noticeNo)
	REFERENCES Notice (noticeNo)
;



