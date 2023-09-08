-- 집합연산다 : 합집합(UNION), 차집함(MINUS), 교집합(INTERSECT)
-- 차집합 연산자 사용
-- 도서를 주문하지 않은 고객의 이름

select name from customer;

select name from customer
where custid in (select custid from orders);

-- 차집합 연산자 사용
select name from customer
minus
select name from customer
where custid in (select distinct custid from orders);

-- 집합연산자 미사용
select name from customer
where custid not in (select distinct custid from orders);

-- EXISTS: 서브쿼리의 결과가 존재하는 경우에 TRUE
-- 주문이 있는 고객의 이름과 주소를 출력
-- in 연산자를 사용한 경우
select name, address from customer
where custid in (select distinct custid from orders); 

-- 동등조인과 중복행 제거
select name, address from customer c, orders o
where c.custid = o.custid ;

-- Exists 사용한 경우
select name, address from customer c
where exists(select * from orders o
                            where c.custid = o.custid);
                    
-- 1-5
select count(distinct publisher) from book b
where b.bookid in(select bookid from orders o, customer c where o.custid = c.custid and c.name ='박지성');
;;;;;
-- 1-6
select bookname, price, price - saleprice from customer c, orders o, book b
where (c.custid = o.custid) and (b.bookid = o.bookid) and (c.custid = 1);

-- 1-7
select name, sum(saleprice) from orders o, customer c
where o.custid = c.custid group by name;

-- 도서의 가격과 판매가격의 차이가 가장 큰 주문
select * from book b, orders o
where b.bookid = o.bookid
and price - saleprice = (select max(price - saleprice)
                                    from book sb, orders so
                                    where sb.bookid = so.bookid);
                                    
-- DDL(Date Defination Language) : 데이터 정의어
-- vreate table/alter table/drop table
-- 테이블 생성 연습 
create table newbook1(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);

-- 테이블 생성 연습 2
-- primary key 설정 방법 1
create table newbook2(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key (bookid)
    );
    
-- primary key 설정 방법 2
create table newbook3(
    bookid number primary key,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
    );
    
-- bookname 컬럼: null값 비허용
-- publisher 컬럼: 동일한 값을 가질 수 없음
-- price 컬럼: 기본값 10000, 최소값 1000초과
-- bookname, publisher 컬럼을 복합키로 설정
create table newbook4(
    bookname varchar2(20) not null ,
    publisher varchar2(20) unique,
    price number default 10000 check (price > 1000),
    
    primary key (bookname, publisher)
    );