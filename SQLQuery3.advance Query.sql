use AdventureWorks2019
go

--Lấy ra dữ liệu của bảng Contact có ContactTypeID >=3 ||<=9
select*from Person.ContactType
where ContactTypeID >=3 and ContactTypeID <= 9

--lấy ra dữ liệu của bảng Contact có contactTypeID trong khoảng [3,9]
select*from Person.ContactType
where ContactTypeID between 3 and 9

--lấy ra dữ liệu trong bảng COntact có ContactTypeID trong tập hợp (3,5,9)
select * from Person.ContactType
where ContactTypeID in (1,3,5,9)

--lấy ra những Contact có lastName kết thúc bởi kí tự e
select * from Person.Person
where LastName like '%e'

--Lấy ra những Contact có lastName bắt đầu bởi kí tự R hoặc A kết thúc bởi kí tự e
select * from Person.Person
where LastName like '[RA]%e'

--Lấy ra những Contact có lastName có 4 kí tự bắt đầu bởi kí tự R hoặc A kết thúc bởi kí tự e
select * from Person.Person
where LastName like '[RA]__e'

-- sử dụng DISTINCT các dữ lieeujt trùng lặp bị loại bỏ
select distinct Title from Person.Person

--sử dụng GROUP BY các dữ liệu trùng lặp được gộp thành 1 nhóm
select Title from Person.Person
GROUP BY Title
--do đó ta có thể dùng các hàm tập hợp
select Title, count(*)[Title Number]
from Person.Person
GROUP BY Title
--có thể kết hợp thêm where
select Title, count(*)[Title Number]
from Person.Person
where Title like 'Mr%'
GROUP BY Title
-- kêt hợp với having: sẽ lọc kết quả trong lúc gộp nhóm
select Title, count(*)[Title Number]
from Person.Person
GROUP BY all Title
having Title like 'Mr%'
--CUBE: tạo thêm 1 hàng siêu kết hợp để gộp tất cả các hàng trong tập trả về
select Title, count(*)[Title Number]
from Person.Person
GROUP BY Title with cube

--ORDER BY: sắp xếp kết quả trả về
select*from Person.Person
ORDER BY FirstName,LastName DESC
/* 
   Truy vấn từ nhiều bảng
   Lấy toàn bộ Contact của nhân viên HumanResources.Employee)
*/
select*from Person.Person
select*from HumanResources.Employee

--Truy vấn con
select * from Person.Person
where BusinessEntityID in(
     select BusinessEntityID
	 from HumanResources.Employee)

-- truy vấn quan hệ sử dụng EXIST
select*from Person.Person C
where EXISTS(
          select BusinessEntityID
		  from HumanResources.Employee
		  where BusinessEntityID=C.BusinessEntityID)

-- kết hợp dữ liệu sử dụng UNION
select ContactTypeID, name
from Person.ContactType
where ContactTypeID in (1,2,3,4,5,6) 
UNION
Select ContactTypeID , name
from Person. ContactType
where ContactTypeID in(1,3,5,7)

-- kết hợp dữ liệu sử dụng UNION với all không loại bỏ giá trị trùng lặp
select ContactTypeID, name
from Person.ContactType
where ContactTypeID in (1,2,3,4,5,6) 
UNION all
Select ContactTypeID , name
from Person. ContactType
where ContactTypeID in(1,3,5,7)

-- sử dụng INNER JOIN 
select* 
from HumanResources.Employee AS e
     INNER JOIN Person.Person AS p
	 ON e.BusinessEntityID=p.BusinessEntityID
ORDER by p.LastName

--MULTIPLE OPERATOR
select distinct p1.ProductSubcategoryID,p1.ListPrice
from Production.Product p1 INNER JOIN Production.Product p2
    on p1.ProductSubcategoryID=p2.ProductSubcategoryID and p1.ListPrice<>p2.ListPrice
where p1.ListPrice< $15 and p2.ListPrice <$15
ORDER BY ProductSubcategoryID;