use javagreen_pjh;

drop table member2;

create table member2 (
idx int not null auto_increment,
mid varchar(80) not null,
pwd varchar(200) not null,
name varchar(50) not null,
tel varchar(60) not null,
email varchar(100) not null,
nickName varchar(60) not null,
post varchar(50) not null,
address varchar(150) not null,
photo varchar(100) default 'noimage.jsp',
content text, 
birthDay datetime default now(),
gender varchar(10) default '선택안함',
userDel varchar(10) default 'NO',
joinDay datetime default now(),
lastDay datetime default now(),
point int default 0,
grade int default 1,
primary key(idx)
);

create table follow2(
	fIdx int not null auto_increment primary key,
	who_Idx int not null,
	for_Idx int not null,
	foreign key(who_Idx) references member2(idx),
	foreign key(for_Idx) references member2(idx)
);

drop table follow2;

select * from member2 order by idx desc limit 0,6;

insert into member2 values(default,'username16','$2a$10$MrCv7LBp2WQtWgLQhmd89eFMwgymc/5TQr5eLj0Reo2ZoarEXSoZW','Admin','010-4096-6697','legozang7@naver.com','관리자','post','address',default,'자기소개가 없습니다',default,default,default,default,default,default,default);
insert into member2 values(default,'admin1','1234','관리자','010-1111-1111','legozang7@naver.com','관리자','post','address',default,'',default,'선택안함',default,default,default,default,default);