-- $ID$
-- TPC-H/TPC-R Product Type Profit Measure Query (Q9)
-- Functional Query Definition
-- Approved February 1998
part = scan('part');
supplier = scan('supplier');
lineitem = scan('lineitem');
partsupp = scan('partsupp');
orders = scan('orders');
nation = scan('nation');


profit =
		select
			n_name as nation,
			year(o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
		from
			part,
			lineitem,
			supplier,
			partsupp,
			orders,
			nation
		where
			s_suppkey = l_suppkey
			and ps_suppkey = l_suppkey
			and ps_partkey = l_partkey
			and p_partkey = l_partkey
			and o_orderkey = l_orderkey
			and s_nationkey = n_nationkey
			and p_name like '%:1%';

q9 = select
	nation,
	o_year,
	sum(amount) as sum_profit
from profit;
--group by  --not needed by MyriaL
--	nation,
--	o_year
--order by --TODO
--	nation,
--	o_year desc;

store(q9, q9);
