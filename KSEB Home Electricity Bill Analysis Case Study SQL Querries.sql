CREATE DATABASE electricity;
use electricity;

-- Imported csv file to run --

SELECT * from Kseb_home_electricity_bill;
                                            
                                            -- SECTION 1 — BASIC --
                                            
-- View all bills --
SELECT 
    Billing_Period, Season, Bill_Date,
    Billing_Days, Meter_Type,
    Total_Units, Bill_Total
FROM Kseb_home_electricity_bill
ORDER BY Bill_Date;

--  Overall totals --
SELECT 
    COUNT(*)                  AS Total_Bills,
    SUM(Billing_Days)         AS Total_Days,
    SUM(Total_Units)          AS Total_Units_kWh,
    ROUND(SUM(Bill_Total), 2) AS Total_Bill_Amount
FROM Kseb_home_electricity_bill;

-- Highest and lowest bill

SELECT 
    Billing_Period, Season,
    Total_Units, Bill_Total
FROM Kseb_home_electricity_bill
WHERE Bill_Total = (SELECT MAX(Bill_Total) FROM Kseb_home_electricity_bill)
   OR Bill_Total = (SELECT MIN(Bill_Total) FROM Kseb_home_electricity_bill);
   

                                      -- SECTION 2 — CONSUMPTION --   
   
   -- Season wise summary --
   
SELECT 
    Season,
    COUNT(*)                   AS Total_Bills,
    SUM(Total_Units)           AS Total_Units,
    ROUND(SUM(Bill_Total), 2)  AS Total_Bill
FROM Kseb_home_electricity_bill
GROUP BY Season
ORDER BY Total_Units DESC;

                                                               -- SECTION 3 — TOD ANALYSIS --

-- What percentage of units used in normal, off-peak and peak hours?

SELECT 
    Billing_Period,
    Normal_Units, `Off-Peak_Units`, Peak_Units, Total_Units,
    ROUND(Normal_Units      * 100.0 / Total_Units, 1) AS Normal_Pct,
    ROUND(`Off-Peak_Units`  * 100.0 / Total_Units, 1) AS OffPeak_Pct,
    ROUND(Peak_Units        * 100.0 / Total_Units, 1) AS Peak_Pct
FROM Kseb_home_electricity_bill
WHERE Meter_Type = 'TOD'
ORDER BY Bill_Date;

-- Overall normal, off-peak and peak split

SELECT 
    SUM(Normal_Units)                                         AS Total_Normal,
    SUM(`Off-Peak_Units`)                                       AS Total_OffPeak,
    SUM(Peak_Units)                                           AS Total_Peak,
    ROUND(SUM(Normal_Units)   * 100.0 / SUM(Total_Units), 1) AS Normal_Pct,
    ROUND(SUM(`Off-Peak_Units`) * 100.0 / SUM(Total_Units), 1) AS OffPeak_Pct,
    ROUND(SUM(Peak_Units)     * 100.0 / SUM(Total_Units), 1) AS Peak_Pct
FROM Kseb_home_electricity_bill
WHERE Meter_Type = 'TOD';

                                      -- SECTION 4 — COST BREAKDOWN --
					
-- Charge breakdown per period --

SELECT 
    Billing_Period,
    Fixed_Charge, Energy_Charge,
    `FSM/_Refund`, Electricity_Duty,
    Meter_Rent, Bill_Total
FROM Kseb_home_electricity_bill
ORDER BY Bill_Date;

-- Total of each charge --

SELECT 
    ROUND(SUM(Fixed_Charge),     2) AS Total_Fixed,
    ROUND(SUM(Energy_Charge),    2) AS Total_Energy,
    ROUND(SUM(`FSM/_Refund`),       2) AS Total_FSM,
    ROUND(SUM(Electricity_Duty), 2) AS Total_Duty,
    ROUND(SUM(Meter_Rent),       2) AS Total_Rent,
    ROUND(SUM(Bill_Total),       2) AS Grand_Total
FROM Kseb_home_electricity_bill;

                                               --  SECTION 5 — COMPARISON --
                                               
-- Highest bill per season --

SELECT Season, Billing_Period, Total_Units, Bill_Total
FROM Kseb_home_electricity_bill k1
WHERE Bill_Total = (
    SELECT MAX(Bill_Total) FROM Kseb_home_electricity_bill k2
    WHERE k2.Season = k1.Season)
ORDER BY Bill_Total DESC;

 -- Lowest bill per season --

SELECT Season, Billing_Period, Total_Units, Bill_Total
FROM Kseb_home_electricity_bill k1
WHERE Bill_Total = (
    SELECT MIN(Bill_Total) FROM Kseb_home_electricity_bill k2
    WHERE k2.Season = k1.Season)
ORDER BY Bill_Total ASC;

-- Cumulative vs TOD comparison --

SELECT 
    Meter_Type,
    COUNT(*)                   AS Total_Bills,
    SUM(Total_Units)           AS Total_Units,
    ROUND(SUM(Bill_Total), 2)  AS Total_Bill
FROM Kseb_home_electricity_bill
GROUP BY Meter_Type;