--Bài 1
create trigger CheckluongNV on NHANVIEN 
for insert 
as
if (select LUONG from inserted) < 15000
begin
	print N'Tiền lương tối thiểu phải lớn hơn 15000 !'
    rollback transaction
end;
insert into NHANVIEN values(N'Nguyễn',N'Thành',N'Nhân','027',cast('1988-11-11'as date),N'236 Lê Văn Sỹ,TpHCM','Nam',30000,'005',5)

--------------------

create trigger ChecktuoiNV on NHANVIEN 
for insert
as
	declare @age int;
	select @age = DATEDIFF(year, ngsinh, GETDATE()) from inserted; 
	if( @age < 18 or @age > 65)
	begin 
		print N'Tuổi phải nằm trong khoảng 18-65'
		rollback transaction
	end;
insert into NHANVIEN values(N'Lê',N'Minh',N'Công','030',cast('1979-05-02'as date),N'100 Nguyễn Văn Đậu','Nam',35000,'006',6)
select*from NHANVIEN;

--------------------

create trigger updateNV on NHANVIEN
for update
as
	if(select DCHI from inserted) like '%TP HCM'
	begin
		print N'Không thể cập nhật'
		rollback transaction
	end;
update NHANVIEN set TENNV = 'Thành' where MANV = '001'

--Bài 2

create trigger tongNV on NHANVIEN
after insert
as
	declare @male int, @female int;
	select @female = count(Manv) from NHANVIEN where PHAI = N'Nữ';
	select @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
	print N'Tổng số nhân viên là nữ: ' + cast(@female as varchar);
	print N'Tổng số nhân viên là nam: ' +cast(@male as varchar);

insert into NHANVIEN values(N'Nguyễn', N'Quang', N'Quý', '035','1990-07-31','TP HCM','Nam', 45000,'001',1)

--------------------

create trigger tongNVsauupdate on NHANVIEN
after update
as
	if(select top 1 PHAI from deleted) != (select top 1 PHAI from inserted)
	begin
		declare @male int, @female int;
		select @female = count(Manv) from NHANVIEN where PHAI = N'Nữ';
		select @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
		print N'Tổng số nhân viên là nữ: ' + cast(@female as varchar);
		print N'Tổng số nhân viên là nam: ' + cast(@male as varchar); 
	end;
update NHANVIEN
set HONV = 'Nguyễn', PHAI = N'Nữ'
where MANV = '015'

--------------------

create trigger tongNVsauxoa on DEAN
after delete
as
begin
	select MA_NVIEN, count(MADA) as 'Số đề án đã tham gia' from PHANCONG
		group by MA_NVIEN
		end;
		select *from DEAN
insert into DEAN values('SQL', 70,'TT',4)
delete from DEAN where MADA = 70

--Bài 3

create trigger xoathannhan on NHANVIEN
instead of delete
as
begin 
	delete from THANNHAN where MA_NVIEN in(select MANV from deleted)
	delete from NHANVIEN where MANV in(select MANV from deleted)
end
insert into THANNHAN values('030','Tuấn','Nam','2010-10-10','con')
delete NHANVIEN where MANV = '030'

--------------------

create trigger NVmoi on NHANVIEN
after insert
as
begin 
	insert into PHANCONG values((select manv from inserted), 1, 2, 20)
end;
insert into NHANVIEN values(N'Trần', N'Thành', N'Trung','040','1988-02-02',N'Hà Nội','Nam',55000,'001',5)

