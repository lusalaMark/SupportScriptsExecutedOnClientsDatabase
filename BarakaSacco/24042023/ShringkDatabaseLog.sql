ALTER DATABASE VanguardFinancialsDB_Baraka_VNEXT SET RECOVERY SIMPLE
DBCC SHRINKFILE (VanguardFinancialsDB_Baraka_VNEXT_Log, 1)
ALTER DATABASE VanguardFinancialsDB_Baraka_VNEXT SET RECOVERY FULL