CREATE PARTITION SCHEME [FactHistoryPSC]
    AS PARTITION [FactPartitionFunctionLeft]
    TO ([FactPartition2005], [FactPartition2006], [FactPartition2007], [FactPartition2008], [FactPartition2009], [FactPartition2010], [FactPartition2011], [FactPartition2012], [FactPartitionDefault]);

