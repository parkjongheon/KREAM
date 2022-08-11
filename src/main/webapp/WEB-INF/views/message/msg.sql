create table msgBox2(
	msgIdx int not null auto_increment primary key,
	msg_memIdx int not null,
	msg_content varchar(200) not null,
	msg_url varchar(200) not null,
	msg_forMemIdx int default 0,
	msg_forMemNick varchar(100) default null,
	msg_val int default 0,
	foreign key(msg_memIdx) references member2(idx)
);
drop table msgBox2;