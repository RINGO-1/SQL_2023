select * from book;

-- book 테이블에서 과학이라는 문자열을 포함하고 도서가격이 15000원 이상
SELECT * from book where price>=15000 and bookname like '%과학%';

-- book 테이블에서 출판사가 굿스포츠 또는 어크로스인 도서
SELECT * from book where publisher='굿스포츠' or publisher='어크로스';

-- 위의 문제를 in 연산자를 사용하도록 수정
SELECT * from book where publisher in('굿스포츠','어크로스');

-- book 테이블에서 도서명순으로 검색
SELECT * from book order by bookname;

-- book 테이블에서 도서번호순으로 검색
SELECT * from book order by bookid;
    
-- book 테이블에서 가격순으로 검색, 같은 가격이면 이름순 검색
SELECT * from book order by price, bookname;

-- book 테이블에서 가격을 내림차순으로 검색, 같은 가격이면 출판사 오름차순 검색
SELECT * from book order by price DESC, bookname ASC;

-- order 테이블에서 고객이 주문한 도서의 총 판매액
-- 집계함수 사용(합계: sum)
SELECT * from orders;

SELECT sum(saleprice) as 총판매액 from orders;

-- orders 테이블에서 고객번호가 1인 고객이 주문한 도서의 총 판매액
SELECT sum(saleprice) from orders where custid=1;

-- order 테이블에서 판매액의 합, 평균, 최소, 최대값
SELECT sum(saleprice) as 총판매금액, avg(saleprice) as 판매액평균, min(saleprice) 최저가, max(saleprice) 최고가 from orders; 

-- orders 테이플에서 판매한 도서의 갯수
SELECT count(*) from orders;

-- orders 테이블에서 도서가격이 13000원 이상인 도서 갯수
SELECT count(*) from orders where saleprice >= 13000;

-- orders 테이블에서 고객번호가 1또는 3인 고객의 주문 갯수
select count(*) from orders where custid = 1 or custid = 3;

-- orders 테이블에서 개격별 주문한 도서의 갯수와 총합계
-- 그룹화 (부분합: group by)
SELECT custid, COUNT(*) 주문수량, sum(saleprice) 주문총액 from orders  group by custid order by custid;

-- orders 테이블에서 판매가격이 8000원 이상인 도서를 구매한 고객별 주문도서의 총 수량
-- 2권이상 구매한 고객만 출력
SELECT custid, COUNT(*) as 도서수량 from orders where saleprice>=8000 group by custid having count(*) >= 2 order by custid; 

--1 
select bookname from book where bookid = 1;

--2
select bookname from book where price >= 20000;

--3 
select sum(saleprice) from orders where custid = 1;

--4
select count(*) from orders where custid =1;

--1
select count(*) from book;

--2
select count(distinct publisher) 출판사 from book;

--3
select name, address from customer;

--4
SELECT orderid FROM orders WHERE orderdate BETWEEN '2023-07-04' AND '2023-07-07';

--5
SELECT orderid FROM orders WHERE orderdate not BETWEEN '2023-07-04' AND '2023-07-07';

--6
select name, address from customer where name like '%김%';

--7
select name, address from customer where name like '%김%' and name like '%아%';

