--Need to know the number of orders (HAWB) in May 2016 based on Ship Date. Just need a number. The orders are in the Orders table.
SELECT COUNT(HAWB) FROM Orders WHERE ShipDate BETWEEN '05/01/2016' AND '05/30/2016';

--Need to know the gross margin for each order in May 2016 based on ship date.
SELECT o.HAWB, o.ShipDate, o.ControlStation, SUM(ord.Amount) as totalRevenue, SUM(ocd.PricePer) as totalCost, totalRevenue - totalCost as margin FROM Orders o
 JOIN Orders_Cost_Detail ocd ON ocd.HAWB = o.HAWB
 JOIN Orders_Revenue_Detail ord ON ord.HAWB = o.HAWB
 WHERE o.ShipDate BETWEEN '05/01/2016' AND '05/30/2016';

--Need to know the gross margin for each order in May 2016 based on ship date for orders assigned to the following control stations: ORD, DFW, LAX
SELECT o.HAWB, o.ShipDate, o.ControlStation, ord.Amount as revenue, ocd.PricePer as itemCost, revenue - itemCost as margin FROM Orders o
 JOIN Orders_Cost_Detail ocd ON ocd.HAWB = o.HAWB
 JOIN Orders_Revenue_Detail ord ON ord.HAWB = o.HAWB
 WHERE o.ShipDate BETWEEN '05/01/2016' AND '05/30/2016' AND (o.ControlStation = 'ORD' OR o.ControlStation = 'DFW' OR o.ControlStation = 'LAX');
--Based on the results from query # 3 above, get the total margin and number of orders for each control station.
SELECT o.ControlStation, COUNT(o.OrdersID) as numOrders, SUM(ord.Amount) - SUM(ocd.PricePer) as margin FROM Orders o
 JOIN Orders_Cost_Detail ocd ON ocd.HAWB = o.HAWB
 JOIN Orders_Revenue_Detail ord ON ord.HAWB = o.HAWB
 GROUP BY o.ControlStation
 WHERE o.ShipDate BETWEEN '05/01/2016' AND '05/30/2016' AND (o.ControlStation = 'ORD' OR o.ControlStation = 'DFW' OR o.ControlStation = 'LAX');